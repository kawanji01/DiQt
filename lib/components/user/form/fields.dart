import 'package:booqs_mobile/components/user/form/language_setting.dart';
import 'package:booqs_mobile/components/user/form/withdrawal_button.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/language.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserFormFields extends ConsumerStatefulWidget {
  const UserFormFields({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  UserFormFieldsState createState() => UserFormFieldsState();
}

class UserFormFieldsState extends ConsumerState<UserFormFields> {
  // validatorを利用するために必要なkey
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _profileController = TextEditingController();
  bool _isRequesting = false;

  @override
  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  void dispose() {
    _nameController.dispose();
    _profileController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nameController.text = widget.user.name;
      _profileController.text = widget.user.profile ?? '';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // 画像
    Future save(User user) async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;
      setState(() => _isRequesting = true);
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map<String, dynamic> params = {
        'id': user.id,
        'public_uid': user.publicUid,
        'name': _nameController.text,
        'profile': _profileController.text,
        'lang_number': ref.watch(userLangNumberProvider),
      };
      try {
        final Map? resMap = await RemoteUsers.update(params);
        await EasyLoading.dismiss();
        setState(() => _isRequesting = false);

        if (resMap == null ||
            resMap['user'] == null ||
            resMap['message'] == null) {
          if (!mounted) return;
          const snackBar = SnackBar(content: Text('アカウントを更新できませんでした。'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          final updatedUser = User.fromJson(resMap['user']);
          ref.read(currentUserProvider.notifier).state = updatedUser;
          // 言語設定の切り替え
          await LanguageService.setLocale(updatedUser);
          final snackBar = SnackBar(content: Text('${resMap['message']}'));
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          UserMyPage.push(context);
        }
      } catch (e) {
        // エラーハンドリング
        await EasyLoading.dismiss();
        setState(() => _isRequesting = false);
        if (!mounted) return;
        final snackBar = SnackBar(content: Text('エラーが発生しました: $e'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 項目フォーム
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        labelText: "名前", hintText: '名前を入力してください。'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '名前は空欄にできません。';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 40),
                  TextFormField(
                    // 複数行のフォーム。 参考： https://stackoverflow.com/questions/54972928/how-to-expand-a-textfield-in-flutter-looks-like-a-text-area
                    minLines: 8,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: _profileController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'プロフィール',
                      hintText: '【空欄可】自己紹介を入力してください。',
                    ),
                  ),
                ],
              ),
              const UserFormLanguageSetting(),
              const SizedBox(height: 40),
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity,
                        40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
                  ),
                  onPressed: _isRequesting
                      ? null
                      : () async {
                          save(widget.user);
                        },
                  icon: const Icon(Icons.edit_outlined, color: Colors.white),
                  label: const Text(
                    '更新する',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 80),
              const UserFormWithdrawalButton(),
              const SizedBox(height: 80),
            ]));
  }
}
