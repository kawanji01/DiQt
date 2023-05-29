import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/session/log_in.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeLogInButton extends StatelessWidget {
  const HomeLogInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        SessionLogInPage.push(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          t.sessions.log_in,
          style: GoogleFonts.mPlusRounded1c(
            textStyle: Theme.of(context).textTheme.headlineMedium,
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
