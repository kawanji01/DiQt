import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/session/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSignUpButton extends StatelessWidget {
  const HomeSignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        SessionSignUpPage.push(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: const Color.fromARGB(255, 51, 223, 91).withAlpha(100),
                  offset: const Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          t.sessions.sign_up,
          /* style: const TextStyle(
            color: Colors.green,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ), */
          style: GoogleFonts.mPlusRounded1c(
            textStyle: Theme.of(context).textTheme.headlineMedium,
            color: Colors.green,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
