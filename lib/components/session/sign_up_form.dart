import 'package:booqs_mobile/components/button/large_orange_button.dart';
import 'package:booqs_mobile/data/provider/bottom_navbar_state.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/remote.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/session/transition.dart';
import 'package:booqs_mobile/components/session/form_field.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionSignUpForm extends ConsumerStatefulWidget {
  const SessionSignUpForm({super.key});

  @override
  SessionSignUpFormState createState() => SessionSignUpFormState();
}

class SessionSignUpFormState extends ConsumerState<SessionSignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isRequesting = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    _nameController.dispose();
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  // Note: Remember to dispose of the TextEditingController when it’s no longer needed. This ensures that you discard any resources used by the object.
  // ref: https://docs.flutter.dev/cookbook/forms/text-field-changes

  @override
  Widget build(BuildContext context) {
    // 送信
    Future submit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      setState(() => _isRequesting = true);

      final String name = _nameController.text;
      final String email = _idController.text;
      final String password = _passwordController.text;

      EasyLoading.show(status: 'loading...');
      final Map resMap =
          await ref.watch(remoteSessionsProvider).signUp(name, email, password);
      EasyLoading.dismiss();
      setState(() => _isRequesting = false);
      if (!context.mounted) return;
      // レスポンスに対する処理
      if (ErrorHandler.isErrorMap(resMap)) {
        _passwordController.text = '';
        ErrorHandler.showErrorSnackBar(context, resMap,
            serverSideMessage: true);
      } else {
        final User user = User.fromJson(resMap['user']);
        final snackBar = SnackBar(content: Text(t.sessions.sign_up_succeeded));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        SessionTransitionPage.push(context, 'logIn');
        // 値の更新
        ref.read(bottomNavbarState.notifier).state = 0;
        await ref.read(currentUserProvider.notifier).logIn(user);
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SessionFormField(
            label: t.sessions.user_name,
            controller: _nameController,
            isPassword: false,
            keyText: 'nameField',
          ),
          SessionFormField(
            label: t.sessions.email,
            controller: _idController,
            isPassword: false,
            keyText: 'emailField',
          ),
          SessionFormField(
            label: "${t.sessions.password}（${t.sessions.password_condition}）",
            controller: _passwordController,
            isPassword: true,
            keyText: 'passwordField',
          ),
          const SizedBox(height: 20),
          // SubmitButton
          InkWell(
              key: const Key('signupSubmitButton'),
              onTap: _isRequesting
                  ? null
                  : () {
                      submit();
                    },
              child: LargeOrangeButton(label: t.sessions.register)),
        ],
      ),
    );
  }
}
