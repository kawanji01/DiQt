import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/user/menu.dart';
import 'package:booqs_mobile/components/button/large_green_button.dart';
import 'package:flutter/material.dart';

class UserMenuButton extends StatelessWidget {
  const UserMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        UserMenuPage.push(context);
      },
      child: LargeGreenButton(label: t.users.menu, icon: Icons.menu),
    );
  }
}
