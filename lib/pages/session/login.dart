import 'package:booqs_mobile/pages/session/sign_up.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/session/apple_button.dart';
import 'package:booqs_mobile/widgets/session/divider_widget.dart';
import 'package:booqs_mobile/widgets/session/google_button.dart';
import 'package:booqs_mobile/widgets/session/login_form.dart';
import 'package:booqs_mobile/widgets/session/twitter_button.dart';
import 'package:booqs_mobile/widgets/bottom_navbar/bottom_navbar.dart';
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
  // パスワードリセット
  Future _moveToInitPasswordPage() async {
    final String url = '${DiQtURL.root(context)}/password_resets/new';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _forgetPassword = Container(
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

    final _signUpLabel = InkWell(
      onTap: () {
        SignUpPage.push(context);
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン'),
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
              const LoginForm(),
              _forgetPassword,
              const DividerWidget(),
              const GoogleButton(),
              const TwitterButton(),
              const AppleButton(),
              const SizedBox(height: 24),
              _signUpLabel,
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
