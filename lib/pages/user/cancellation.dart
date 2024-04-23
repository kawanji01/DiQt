import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/object_wrappers.dart';

class UserCancellationPage extends ConsumerStatefulWidget {
  const UserCancellationPage({Key? key}) : super(key: key);

  static Future push(
      BuildContext context, EntitlementInfo entitlementInfo) async {
    return Navigator.of(context).pushNamed(userCancellationPage,
        arguments: {'entitlementInfo': entitlementInfo});
  }

  @override
  UserCancellationPageState createState() => UserCancellationPageState();
}

class UserCancellationPageState extends ConsumerState<UserCancellationPage> {
  EntitlementInfo? _entitlementInfo;
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  bool _isRequesting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      _entitlementInfo = arguments['entitlementInfo'];
      setState(() {
        _entitlementInfo;
      });
    });
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_entitlementInfo == null) return const LoadingSpinner();

    const TextStyle textStyle = TextStyle(fontSize: 16, color: Colors.black87);
    final User? user = ref.watch(currentUserProvider);
    if (user == null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 32),
        child: const Text('Please login.'),
      );
    }

    // 解約処理
    Future sendCancellationReport(EntitlementInfo entitlementInfo) async {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      setState(() {
        _isRequesting = true;
      });
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteUsers.sendCancellationReport(
          entitlementInfo, _reasonController.text);
      // 画面全体のローディングを消す。
      EasyLoading.dismiss();
      // リクエストロック終了
      setState(() {
        _isRequesting = false;
      });
      if (!context.mounted) return;

      if (resMap == null) {
        const snackBar = SnackBar(content: Text('通信エラーが発生しました。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        UserMyPage.push(context);
        WebPageLauncher.openCancellationPage(entitlementInfo);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('解約の確認'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}さま',
                  style: textStyle,
                ),
                const Text(
                  'これまでDiQtのプレミアムプランをご利用いただき、誠にありがとうございました...!',
                  style: textStyle,
                ),
                const Text(
                  'そして、今回ご期待に沿えなかったこと、大変申し訳なく思います....。',
                  style: textStyle,
                ),
                Text(
                  'よろしければ、ぜひ今後のサービス改善のために、${user.name}さまがこの度プランをご解約されるにいたった理由を教えていただけないでしょうか...？',
                  style: textStyle,
                ),
                const Text(
                  'お手数をおかけして大変申し訳ございません...!',
                  style: textStyle,
                ),
                const Text(
                  'なにとぞ率直なご感想を、どうかよろしくお願いいたします...！！🙇‍♂️',
                  style: textStyle,
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  controller: _reasonController,
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "解約理由",
                      hintText: '解約に至った理由を教えてください...!🙇‍♂️'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '解約理由は空欄にできません。';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity,
                        40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
                  ),
                  onPressed: _isRequesting
                      ? null
                      : () async {
                          sendCancellationReport(_entitlementInfo!);
                        },
                  child: const Text(
                    '解約する',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
