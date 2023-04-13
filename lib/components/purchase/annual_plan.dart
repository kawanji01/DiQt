import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/purchase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PurchaseAnnualPlan extends StatefulWidget {
  const PurchaseAnnualPlan({Key? key}) : super(key: key);

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
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(33, 24, 33, 24),
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
                  "年額プラン",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "5000円/年",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "417円/月",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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
              child: const Text(
                "２ヶ月分お得！",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
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
