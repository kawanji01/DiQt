import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/session/login.dart';
import 'package:flutter/material.dart';

class HomeLogInButton extends StatelessWidget {
  const HomeLogInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        SessionLoginPage.push(context);
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
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
