import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/purchase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PurchaseMonthlyplan extends StatefulWidget {
  const PurchaseMonthlyplan({Key? key}) : super(key: key);

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
        const snackBar = SnackBar(content: Text('プレミアム会員になりました！'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
      }
    }

    return GestureDetector(
      onTap: () => subscribe(context),
      child: Container(
        padding: const EdgeInsets.fromLTRB(32, 24, 32, 45),
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
          children: const [
            Text(
              "月額プラン",
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "500円/月",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
