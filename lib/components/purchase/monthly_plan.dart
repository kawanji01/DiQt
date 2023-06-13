import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/purchase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PurchaseMonthlyplan extends StatefulWidget {
  const PurchaseMonthlyplan({Key? key, required this.width}) : super(key: key);
  final double width;

  @override
  State<PurchaseMonthlyplan> createState() => _PurchaseMonthlyplanState();
}

class _PurchaseMonthlyplanState extends State<PurchaseMonthlyplan> {
  @override
  Widget build(BuildContext context) {
    // 決済関連のクラスのインスタンス化
    final purchase = PurchaseService();

    Future subscribe(BuildContext context) async {
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      // 購入する
      final bool subscriptionCompleted = await purchase.purchaseMonthlyPlan();
      // 画面全体のローディングを消す。
      EasyLoading.dismiss();
      if (!mounted) return;
      // 契約完了したらマイページに画面遷移
      if (subscriptionCompleted) {
        final snackBar = SnackBar(content: Text(t.purchase.purchase_succeded));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
      }
    }

    return GestureDetector(
      onTap: () => subscribe(context),
      child: Container(
        padding: const EdgeInsets.only(top: 24, bottom: 45),
        width: widget.width,
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
              t.purchase.monthly_plan,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              t.purchase.monthly_plan_price,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
