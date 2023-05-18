import 'package:booqs_mobile/components/home/introduction.dart';
import 'package:booqs_mobile/components/home/log_in_button.dart';
import 'package:booqs_mobile/components/home/sign_up_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
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
        child: Column(children: [
          Expanded(
            child: PageView(
              children: [
                HomeIntroduction(
                  title: t.home.welcome,
                  description: t.home.welcome_description,
                  icon: Icons.one_k,
                ),
                const HomeIntroduction(
                  title: 'Learn More',
                  description: 'This is the second page of our walkthrough.',
                  icon: Icons.two_k,
                ),
                const HomeIntroduction(
                  title: 'Get Started',
                  description: 'This is the final page of our walkthrough.',
                  icon: Icons.three_k,
                ),
              ],
            ),
          ),
          const HomeSignUpButton(),
          const SizedBox(height: 40),
          const HomeLogInButton(),
          const SizedBox(height: 80),
        ]),
      ),
    );
  }
}
