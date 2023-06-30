import 'package:booqs_mobile/components/purchase/introduction.dart';
import 'package:booqs_mobile/components/purchase/introduction_footer.dart';
import 'package:booqs_mobile/components/purchase/restore_button.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';

class PurchaseMobileScreen extends StatelessWidget {
  const PurchaseMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: ResponsiveValues.horizontalMargin(context)),
        color: Colors.transparent,
        child: const Column(
          children: <Widget>[
            SizedBox(
              height: 24,
            ),
            PurchaseIntroduction(),
            SizedBox(
              height: 48,
            ),
            SizedBox(
              height: 24,
            ),
            PurchaseIntroductionFooter(),
            SizedBox(
              height: 32,
            ),
            PurchaseRestoreButton(),
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
