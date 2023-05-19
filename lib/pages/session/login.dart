import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/session/sign_up.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:booqs_mobile/components/session/apple_button.dart';
import 'package:booqs_mobile/components/session/divider_widget.dart';
import 'package:booqs_mobile/components/session/google_button.dart';
import 'package:booqs_mobile/components/session/login_form.dart';
import 'package:booqs_mobile/components/session/twitter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionLoginPage extends ConsumerWidget {
  const SessionLoginPage({super.key});

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(loginPage);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /*  final User? user = ref.watch(currentUserProvider);
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(t.sessions.log_in),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: const Text('You have already logged in.'),
        ),
      );
    } */

    return Scaffold(
      appBar: AppBar(
        title: Text(t.sessions.log_in),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: ResponsiveValues.horizontalMargin(context)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 48),
              const SessionLoginForm(),
              // forgetPassword パスワードリセット
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    final String url =
                        '${DiQtURL.root(context)}/password_resets/new';
                    WebPageLauncher.openByWebView(url);
                  },
                  child: Text(t.sessions.forgot_password,
                      style: const TextStyle(color: Colors.black87)),
                ),
              ),
              const SessionDividerWidget(),
              const SizedBox(height: 24),
              const SessionGoogleButton(),
              const SizedBox(height: 24),
              const SessionAppleButton(),
              const SizedBox(height: 24),
              const SessionTwitterButton(),

              const SizedBox(height: 24),
              // SignUp recommendation
              InkWell(
                onTap: () {
                  SessionSignUpPage.push(context);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        t.sessions.dont_have_account,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        t.sessions.sign_up,
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
