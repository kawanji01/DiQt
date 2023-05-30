import 'package:booqs_mobile/components/button/large_orange_button.dart';
import 'package:booqs_mobile/data/provider/bottom_navbar_state.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/data/remote/sessions.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/session/transition.dart';
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
      if (!_formKey.currentState!.validate()) {
        return;
      }
      try {
        final String email = _idController.text;
        final String password = _passwordController.text;
        // 画面全体にローディングを表示
        EasyLoading.show(status: 'loading...');
        Map? resMap = await RemoteSessions.login(email, password);
        EasyLoading.dismiss();
        if (resMap == null) {
          if (!mounted) return;
          _passwordController.clear();
          final snackBar = SnackBar(content: Text(t.sessions.login_failed));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          User user = User.fromJson(resMap['user']);
          // await UserSetup.signIn(user);
          //if (!mounted) return;

          await ref.read(currentUserProvider.notifier).logIn(user);
          // Localeの更新
          await ref.read(localeProvider.notifier).setLocale();
          ref.read(bottomNavbarState.notifier).state = 0;
          final snackBar = SnackBar(content: Text(t.sessions.login_succeeded));
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          SessionTransitionPage.push(context, 'logIn');
        }
      } catch (e) {
        _passwordController.clear();
        final snackBar = SnackBar(content: Text(t.errors.error_occured));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
