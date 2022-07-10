import 'dart:convert';

import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/widgets/user/withdrawal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  // validatorを利用するために必要なkey
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _profileController = TextEditingController();

  @override
  // widgetの破棄時にコントローラも破棄する。Controllerを使うなら必ず必要。
  // 参考： https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
  void dispose() {
    _nameController.dispose();
    _profileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User _user = ModalRoute.of(context)!.settings.arguments as User;
    _nameController.text = _user.name;
    _profileController.text = _user.profile ?? '';

    // 画像
    Future _save(user) async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;

      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');

      // リクエスト
      var url = Uri.parse(
          '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/users/${user.publicUid}');

      Response response = await patch(url, body: {
        'token': token,
        'name': _nameController.text,
        'profile': _profileController.text,
      });

      if (response.statusCode == 200) {
        // 画面全体のローディングを消す。
        EasyLoading.dismiss();
        Map<String, dynamic> resMap = json.decode(response.body);
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
      } else {
        EasyLoading.dismiss();
        const snackBar = SnackBar(content: Text('アカウントを更新できませんでした。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    // 更新ボタン
    Widget _submitButton() {
      return SizedBox(
        height: 48,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity,
                40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
          ),
          onPressed: () => {
            _save(_user),
          },
          icon: const Icon(Icons.edit_outlined, color: Colors.white),
          label: const Text(
            '更新する',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
    }

    Widget _userForm() {
      return Column(
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
          // 解説フォーム
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
      );
    }

    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _userForm(),
              const SizedBox(height: 40),
              _submitButton(),
              const SizedBox(height: 80),
              UserWithdrawalButton(user: _user),
              const SizedBox(height: 80),
            ]));
  }
}
