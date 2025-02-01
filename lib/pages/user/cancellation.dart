import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
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
  const UserCancellationPage({super.key});

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
        child: Text(t.cancellation.please_login),
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
        final snackBar = SnackBar(content: Text(t.cancellation.communication_error));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        UserMyPage.push(context);
        WebPageLauncher.openCancellationPage(entitlementInfo);
      }
    }

    return Scaffold(
      appBar: const AppBarDefault(
        title: '解約の確認',
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
                  t.cancellation.user_name_suffix(user: user.name),
                  style: textStyle,
                ),
                Text(
                  t.cancellation.premium_thanks,
                  style: textStyle,
                ),
                Text(
                  t.cancellation.apology_message,
                  style: textStyle,
                ),
                Text(
                  t.cancellation.feedback_request(user: user.name),
                  style: textStyle,
                ),
                Text(
                  t.cancellation.apology_for_trouble,
                  style: textStyle,
                ),
                Text(
                  t.cancellation.honest_feedback_request,
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
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: t.cancellation.cancellation_reason_title,
                      hintText: t.cancellation.cancellation_reason_request),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return t.cancellation.cancellation_reason_required;
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
                  child: Text(
                    t.cancellation.cancel_subscription,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
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
