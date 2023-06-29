import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class HomeWalkthrough2 extends StatelessWidget {
  const HomeWalkthrough2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 32),
            child: Image.asset('assets/images/walkthrough_2.png'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Text(t.home.welcome_description_2,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              )
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
