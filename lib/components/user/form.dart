import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/components/user/withdrawal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserForm extends ConsumerStatefulWidget {
  const UserForm({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  UserFormState createState() => UserFormState();
}

class UserFormState extends ConsumerState<UserForm> {
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
      final Map? resMap = await RemoteUsers.update(
          user.publicUid, _nameController.text, _profileController.text);
      await EasyLoading.dismiss();
      setState(() => _isRequesting = false);
      if (!mounted) return;
      if (resMap == null) {
        const snackBar = SnackBar(content: Text('アカウントを更新できませんでした。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final updatedUser = User.fromJson(resMap['user']);
        ref.read(currentUserProvider.notifier).state = updatedUser;
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
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
              const UserWithdrawalButton(),
              const SizedBox(height: 80),
            ]));
  }
}
