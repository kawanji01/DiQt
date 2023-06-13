import 'package:booqs_mobile/components/purchase/benefits_screen.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class PurchaseBenefitsButton extends StatelessWidget {
  const PurchaseBenefitsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.only(left: 0),
        ),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
            ),
            // showModalBottomSheetで表示される中身
            builder: (context) => const PurchaseBenefitsScreen(),
          );
        },
        child: Text(
          t.purchase.view_premium_plan_benefits,
          style: const TextStyle(
              color: Colors.green,
              fontSize: 16,
              decoration: TextDecoration.underline),
        ));
  }
}
