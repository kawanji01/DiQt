import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/session/log_in.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/session/apple_button.dart';
import 'package:booqs_mobile/components/session/divider_widget.dart';
import 'package:booqs_mobile/components/session/google_button.dart';
import 'package:booqs_mobile/components/session/twitter_button.dart';
import 'package:booqs_mobile/components/session/sign_up_form.dart';
import 'package:flutter/material.dart';

class SessionSignUpPage extends StatelessWidget {
  const SessionSignUpPage({super.key});

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(sessionSignUpPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.sessions.sign_up),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: ResponsiveValues.horizontalMargin(context)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              const SessionSignUpForm(),
              const SizedBox(
                height: 24,
              ),
              const SessionDividerWidget(),
              const SizedBox(
                height: 24,
              ),
              const SessionGoogleButton(),
              const SizedBox(
                height: 24,
              ),
              const SessionAppleButton(),
              const SizedBox(
                height: 24,
              ),
              const SessionTwitterButton(),

              // login recommendation
              InkWell(
                onTap: () {
                  SessionLogInPage.push(context);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        t.sessions.already_have_an_account,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        t.sessions.log_in,
                        style: const TextStyle(
                            color: Color(0xfff79c4f),
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
