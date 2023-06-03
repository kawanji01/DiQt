import 'package:booqs_mobile/components/home/log_in_button.dart';
import 'package:booqs_mobile/components/home/sign_up_button.dart';
import 'package:booqs_mobile/components/home/walkthrough.dart';
import 'package:booqs_mobile/components/home/drawer_menu.dart';

import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';

class HomeSignInScreen extends StatelessWidget {
  const HomeSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context),
        ),
        child: Column(children: const [
          Expanded(
            child: HomeWalkthrough(),
            //child: HomeIntroduction(),
          ),
          HomeSignUpButton(),
          SizedBox(height: 40),
          HomeLogInButton(),
          SizedBox(height: 80),
        ]),
      ),
      drawer: const DrawerMenu(),
    );
  }
}
