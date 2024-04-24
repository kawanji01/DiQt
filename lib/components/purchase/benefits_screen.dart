import 'package:booqs_mobile/consts/validation.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PurchaseBenefitsScreen extends StatelessWidget {
  const PurchaseBenefitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget title(String title) {
      return Text(
        title,
        style: const TextStyle(
            fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold),
      );
    }

    Widget description(String description) {
      return Text(
        description,
        style: const TextStyle(fontSize: 16, color: Colors.black54),
      );
    }

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
          title(t.purchase.unlimited_answers),
          description(
            t.purchase.unlimited_answers_description(
                number: answersCountLimitForFreeUsers),
          ),
          const SizedBox(height: 48),
          title(t.purchase.unlimited_translations),
          description(
            t.purchase.unlimited_translations_description(
                number: translationsCountLimitForFreeUsers),
          ),
          const SizedBox(height: 48),
          title(t.purchase.weakness),
          description(
            t.purchase.weakness_description,
          ),
          const SizedBox(height: 48),
          title(t.purchase.note),
          description(
            t.purchase.note_description,
          ),
          const SizedBox(height: 48),
          title(t.purchase.answer_analysis),
          description(
            t.purchase.answer_analysis_description,
          ),
          const SizedBox(height: 48),
          title(t.purchase.answer_history),
          description(
            t.purchase.answer_history_description,
          ),
          const SizedBox(height: 48),
          title(t.purchase.questions_you_got_wrong),
          description(
            t.purchase.questions_you_got_wrong_description,
          ),
          const SizedBox(height: 48),
          title(t.purchase.deletion_of_all_reviews),
          description(
            t.purchase.deletion_of_all_reviews_description,
          ),
          const SizedBox(height: 48),
          title(t.purchase.ad_free),
          description(
            t.purchase.ad_free_description,
          ),
          const SizedBox(height: 120),
        ],
      )),
    );
  }
}
