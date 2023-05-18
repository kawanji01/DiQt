import 'package:booqs_mobile/components/button/large_orange_button.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/data/remote/sessions.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:booqs_mobile/components/session/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionLoginForm extends ConsumerStatefulWidget {
  const SessionLoginForm({Key? key}) : super(key: key);

  @override
  SessionLoginFormState createState() => SessionLoginFormState();
}

class SessionLoginFormState extends ConsumerState<SessionLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 送信
    Future submit() async {
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      if (!_formKey.currentState!.validate()) {
        // ローディングを消す
        EasyLoading.dismiss();
        return;
      }
      final String email = _idController.text;
      final String password = _passwordController.text;
      Map? resMap = await RemoteSessions.login(email, password);
      EasyLoading.dismiss();
      if (resMap == null) {
        if (!mounted) return;
        _passwordController.clear();
        const snackBar = SnackBar(content: Text('メールアドレスまたはパスワードが違います。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        User user = User.fromJson(resMap['user']);
        await UserSetup.signIn(user);
        if (!mounted) return;
        ref.read(currentUserProvider.notifier).state = user;
        const snackBar = SnackBar(content: Text('ログインしました。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        await UserMyPage.push(context);
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SessionFormField(
              label: t.sessions.email,
              controller: _idController,
              isPassword: false),
          SessionFormField(
              label: t.sessions.password,
              controller: _passwordController,
              isPassword: true),
          const SizedBox(height: 20),
          InkWell(
              onTap: () {
                submit();
              },
              child: LargeOrangeButton(
                label: t.sessions.log_in,
              )),
        ],
      ),
    );
  }
}
