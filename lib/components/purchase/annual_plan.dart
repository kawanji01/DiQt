import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/purchase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PurchaseAnnualPlan extends StatefulWidget {
  const PurchaseAnnualPlan({super.key, required this.width});
  final double width;

  @override
  State<PurchaseAnnualPlan> createState() => _PurchaseAnnualPlanState();
}

class _PurchaseAnnualPlanState extends State<PurchaseAnnualPlan> {
  @override
  Widget build(BuildContext context) {
    // 決済関連のクラスのインスタンス化
    final purchase = PurchaseService();
    // 課金
    Future subscribe(BuildContext context) async {
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      // 購入する
      final bool subscriptionCompleted = await purchase.purchaseAnnualPlan();
      // 画面全体のローディングを消す。
      EasyLoading.dismiss();
      if (!context.mounted) return;
      // 契約完了したらマイページに画面遷移
      if (subscriptionCompleted) {
        final snackBar = SnackBar(content: Text(t.purchase.purchase_succeded));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
      }
    }

    return GestureDetector(
      onTap: () => subscribe(context),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: widget.width,
            padding: const EdgeInsets.only(top: 24, bottom: 45),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              border: Border.all(
                width: 2,
                color: Colors.green,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.purchase.annual_plan,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  t.purchase.annual_plan_price,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // バッジ
          Positioned(
            top: -11,
            right: 8,
            child: Container(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.redAccent,
              ),
              child: Text(
                t.purchase.two_months_free,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
