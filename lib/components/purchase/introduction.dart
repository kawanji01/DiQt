import 'package:booqs_mobile/components/purchase/annual_plan.dart';
import 'package:booqs_mobile/components/purchase/benefits_button.dart';
import 'package:booqs_mobile/components/purchase/heading.dart';
import 'package:booqs_mobile/components/purchase/monthly_plan.dart';
import 'package:booqs_mobile/components/purchase/features_table.dart';
import 'package:booqs_mobile/components/purchase/benefits_list.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';

class PurchaseIntroduction extends StatelessWidget {
  const PurchaseIntroduction({super.key});

  @override
  Widget build(BuildContext context) {
    // プレミアムプランの説明
    double grid = SizeConfig.blockSizeHorizontal ?? 0;
    // 画面の40%
    double width = grid * 40;
    double paddingWidth = grid * 6;

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const PurchaseHeading(),
          const SizedBox(
            height: 24,
          ),
          Text(
            t.purchase.premium_plan_description,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(
            height: 24,
          ),
          const PurchaseBenefitsList(),
          const SizedBox(
            height: 24,
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                t.purchase.trial_period_description,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              const Spacer(),
              PurchaseMonthlyplan(
                width: width,
              ),
              SizedBox(width: paddingWidth),
              PurchaseAnnualPlan(
                width: width,
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          const PurchaseFeaturesTable(),
          const SizedBox(
            height: 32,
          ),
          const PurchaseBenefitsButton()
        ],
      ),
    );
  }
}
