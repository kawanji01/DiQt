import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/purchase/introduction.dart';
import 'package:booqs_mobile/widgets/purchase/introduction_footer.dart';
import 'package:booqs_mobile/widgets/purchase/subscription_button.dart';
import 'package:booqs_mobile/widgets/purchase/restore_button.dart';
import 'package:booqs_mobile/widgets/bottom_navbar/bottom_navbar.dart';
import 'package:flutter/material.dart';

// プレミアムプランの紹介・課金ページ
class PremiumPlanPage extends StatefulWidget {
  const PremiumPlanPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(userPremiumPlanPage);
  }

  @override
  _PremiumPlanPageState createState() => _PremiumPlanPageState();
}

class _PremiumPlanPageState extends State<PremiumPlanPage> {
  @override
  Widget build(BuildContext context) {
    Widget _body() {
      return Column(
        children: const <Widget>[
          SizedBox(
            height: 24,
          ),
          PurchaseIntroduction(),
          SizedBox(
            height: 48,
          ),
          PurchaseSubscriptionButton(),
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
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('プレミアムプラン'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          color: Colors.transparent,
          child: _body(),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
