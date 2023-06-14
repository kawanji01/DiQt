import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PurchaseHeading extends StatelessWidget {
  const PurchaseHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const WidgetSpan(
            child: FaIcon(
              FontAwesomeIcons.crown,
              size: 34,
              color: Colors.green,
            ),
          ),
          const TextSpan(text: ' '),
          TextSpan(
              text: t.purchase.premium_plan,
              style: const TextStyle(
                  color: Colors.green,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 2)),
        ],
      ),
    );
  }
}
