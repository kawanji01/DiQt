import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/components/user/form/password_setting_recommendation.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class UserFormAuthentication extends StatelessWidget {
  const UserFormAuthentication(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.passwordConfirmationController});
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadingMediumGreen(label: t.users.authentication),
        const UserFormPasswordSettingRecommendation(),
        const SizedBox(
          height: 24,
        ),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(labelText: t.users.email),
          validator: (value) {
            if (value!.isEmpty) {
              return t.errors.cant_be_blank;
            }
            return null;
          },
        ),
        const SizedBox(
          height: 48,
        ),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
              labelText: t.users.new_password,
              hintText: t.users.new_password_placeholder),
        ),
        const SizedBox(
          height: 48,
        ),
        TextFormField(
          controller: passwordConfirmationController,
          obscureText: true,
          decoration: InputDecoration(
              labelText: t.users.new_password_confirmation,
              hintText: t.users.new_password_confirmation_placeholder),
        ),
      ],
    );
  }
}
