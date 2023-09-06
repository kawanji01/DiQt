import 'package:booqs_mobile/components/purchase/desktop_screen.dart';
import 'package:booqs_mobile/components/purchase/mobile_screen.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/analytics_service.dart';
import 'package:booqs_mobile/utils/env_handler.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:flutter/material.dart';

// プレミアムプランの紹介・課金ページ
class PremiumPlanPage extends StatefulWidget {
  const PremiumPlanPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(userPremiumPlanPage);
  }

  @override
  createState() => _PremiumPlanPageState();
}

class _PremiumPlanPageState extends State<PremiumPlanPage> {
  @override
  void initState() {
    super.initState();
    // analytics に記録する
    AnalyticsService().setCurrentScreen('PremiumPlanPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.purchase.premium_plan),
      ),
      body: EnvHandler.isMobile()
          ? const PurchaseMobileScreen()
          : const PurchaseDesktopScreen(),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
