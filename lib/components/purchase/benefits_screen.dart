import 'package:booqs_mobile/consts/validation.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PurchaseBenefitsScreen extends StatelessWidget {
  const PurchaseBenefitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveValues.dialogHeight(context),
      margin: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context)),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FaIcon(
                FontAwesomeIcons.crown,
                size: 26,
                color: Colors.green,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                t.purchase.premium_plan_benefits,
                style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              )
            ],
          ),
          const SizedBox(height: 48),
          Text(
            t.purchase.unlimited_answers,
            style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          Text(
            t.purchase.unlimited_answers_description(
                number: answersCountLimitForFreeUsers),
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 48),
          Text(
            t.purchase.translations_limit,
            style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 48),
        ],
      )),
    );
  }
}
