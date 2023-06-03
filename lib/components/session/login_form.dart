import 'package:booqs_mobile/components/button/large_orange_button.dart';
import 'package:booqs_mobile/data/provider/bottom_navbar_state.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/session.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/session/transition.dart';
import 'package:booqs_mobile/components/session/form_field.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
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
    Future submit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      final String email = _idController.text;
      final String password = _passwordController.text;
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map resMap =
          await ref.watch(remoteSessionsProvider).login(email, password);
      EasyLoading.dismiss();
      if (!mounted) return;
      if (ErrorHandler.isErrorMap(resMap)) {
        _passwordController.clear();
        final message = ErrorHandler.message(resMap, useServerMessage: true);
        final snackBar = SnackBar(content: Text(message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final User user = User.fromJson(resMap['user']);
        final snackBar = SnackBar(content: Text(t.sessions.login_succeeded));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        SessionTransitionPage.push(context, 'logIn');
        // データの更新（SnackBarやSessionTrasnsitonの上で実行するとテストが通らなくなる）
        ref.read(bottomNavbarState.notifier).state = 0;
        await ref.read(currentUserProvider.notifier).logIn(user);
      }
    }

    // 送信
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SessionFormField(
            label: t.sessions.email,
            controller: _idController,
            isPassword: false,
            keyText: 'emailField',
          ),
          SessionFormField(
              label: t.sessions.password,
              controller: _passwordController,
              isPassword: true,
              keyText: 'passwordField'),
          const SizedBox(height: 20),
          InkWell(
              key: const Key('loginSubmitButton'),
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
