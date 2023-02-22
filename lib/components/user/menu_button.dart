import 'package:booqs_mobile/pages/user/menu.dart';
import 'package:booqs_mobile/components/button/large_green_button.dart';
import 'package:flutter/material.dart';

class UserMenuButton extends StatelessWidget {
  const UserMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String btnText = 'メニュー';

    return InkWell(
      onTap: () {
        UserMenuPage.push(context);
      },
      child: const LargeGreenButton(label: btnText, icon: Icons.menu),
    );
  }
}
