import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/components/user/withdrawal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
    final User user = ModalRoute.of(context)!.settings.arguments as User;
    _nameController.text = user.name;
    _profileController.text = user.profile ?? '';

    // 画像
    Future save(user) async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;

      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteUsers.update(
          user.publicUid, _nameController.text, _profileController.text);
      EasyLoading.dismiss();
      if (!mounted) return;
      if (resMap == null) {
        const snackBar = SnackBar(content: Text('アカウントを更新できませんでした。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
      }
    }

    // 更新ボタン
    Widget submitButton() {
      return SizedBox(
        height: 48,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity,
                40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
          ),
          onPressed: () => {
            save(user),
          },
          icon: const Icon(Icons.edit_outlined, color: Colors.white),
          label: const Text(
            '更新する',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
    }

    Widget userForm() {
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
              userForm(),
              const SizedBox(height: 40),
              submitButton(),
              const SizedBox(height: 80),
              const UserWithdrawalButton(),
              const SizedBox(height: 80),
            ]));
  }
}
