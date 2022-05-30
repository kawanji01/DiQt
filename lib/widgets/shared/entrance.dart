import 'package:booqs_mobile/pages/session/login.dart';
import 'package:booqs_mobile/pages/session/sign_up.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Entrance extends StatelessWidget {
  const Entrance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ログインボタン
    Widget _submitButton() {
      return InkWell(
        onTap: () {
          LoginPage.push(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: const Color(0xff84bf53).withAlpha(100),
                    offset: const Offset(2, 4),
                    blurRadius: 8,
                    spreadRadius: 2)
              ],
              color: Colors.green),
          child: const Text(
            'ログイン',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    // 新規登録ボタン
    Widget _signUpButton() {
      return InkWell(
        onTap: () {
          SignUpPage.push(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.green, width: 2),
          ),
          child: const Text(
            '新規登録',
            style: TextStyle(
                fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    Widget _label() {
      return Container(
        margin: const EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              'この機能を利用するにはログインが必要です。',
              style: GoogleFonts.notoSans(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w100),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 80,
          ),
          _submitButton(),
          const SizedBox(
            height: 40,
          ),
          _signUpButton(),
          _label(),
          const SizedBox(
            height: 40,
          ),
          const AppBanner(),
        ],
      ),
    );
  }
}
