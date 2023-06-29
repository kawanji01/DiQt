import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class HomeWalkthrough4 extends StatelessWidget {
  const HomeWalkthrough4({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 32),
            child: Image.asset('assets/images/walkthrough_4.png'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Text(
            t.home.welcome_description_4,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
            ),
            /* style: GoogleFonts.mPlusRounded1c(
              textStyle: Theme.of(context).textTheme.headlineSmall,
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
            ), */
          ),
        ),
      ],
    );
  }
}
