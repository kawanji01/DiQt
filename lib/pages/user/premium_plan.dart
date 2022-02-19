import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/purchase/introduction.dart';
import 'package:booqs_mobile/widgets/purchase/introduction_footer.dart';
import 'package:booqs_mobile/widgets/purchase/subscription_button.dart';
import 'package:booqs_mobile/widgets/purchase/restore_button.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:flutter/material.dart';

// プレミアムプランの紹介・課金ページ
class PremiumPlanPage extends StatefulWidget {
  const PremiumPlanPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(premiumPlanPage);
  }

  @override
  _PremiumPlanPageState createState() => _PremiumPlanPageState();
}

class _PremiumPlanPageState extends State<PremiumPlanPage> {
  @override
  Widget build(BuildContext context) {
    Widget _body() {
      return SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 28),
          color: Colors.transparent,
          child: Column(
            children: const <Widget>[
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
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('プレミアムプラン'),
        //automaticallyImplyLeading: false,
      ),
      body: _body(),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 3),
    );
  }
}
