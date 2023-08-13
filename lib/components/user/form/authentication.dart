import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/components/user/form/email_change_screen.dart';
import 'package:booqs_mobile/components/user/form/password_setting_recommendation.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';

class UserFormAuthentication extends StatelessWidget {
  const UserFormAuthentication(
      {super.key,
      required this.user,
      required this.passwordController,
      required this.passwordConfirmationController});
  final User user;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadingMediumGreen(label: t.users.authentication),
        const UserFormPasswordSettingRecommendation(),
        const SizedBox(
          height: 24,
        ),
        TextFormField(
          readOnly: true,
          initialValue: user.email ?? '',
          decoration: InputDecoration(
            labelText: t.users.email,
          ),
        ),
        TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.only(left: 0),
            ),
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                  ),
                  builder: (context) => const UserFormEmailChangeScreen());
            },
            child: Text(
              t.users.change_email,
              style: const TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            )),
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
