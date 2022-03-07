import 'package:booqs_mobile/pages/session/sign_up.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/session/apple_button.dart';
import 'package:booqs_mobile/widgets/session/divider_widget.dart';
import 'package:booqs_mobile/widgets/session/google_button.dart';
import 'package:booqs_mobile/widgets/session/login_form.dart';
import 'package:booqs_mobile/widgets/session/twitter_button.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(loginPage);
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future _moveToInitPasswordPage() async {
    final String url =
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/password_resets/new';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    }
  }

  Widget _forgotPassword() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: () => _moveToInitPasswordPage(),
        child: const Text('パスワードを忘れましたか?',
            style: TextStyle(color: Colors.black87)),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignUpPage()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'アカウントを持っていませんか？',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '新規登録',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン'),
      ),
      body: SizedBox(
        height: height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 48),
                    LoginForm(),
                    _forgotPassword(),
                    const DividerWidget(),
                    const GoogleButton(),
                    const TwitterButton(),
                    const AppleButton(),
                    const SizedBox(height: 24),
                    _createAccountLabel(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 3),
    );
  }
}
