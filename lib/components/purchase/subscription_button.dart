import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/services/purchase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PurchaseSubscriptionButton extends StatefulWidget {
  const PurchaseSubscriptionButton({Key? key}) : super(key: key);

  @override
  State<PurchaseSubscriptionButton> createState() =>
      _PurchaseSubscriptionButtonState();
}

class _PurchaseSubscriptionButtonState
    extends State<PurchaseSubscriptionButton> {
  @override
  Widget build(BuildContext context) {
    // 決済関連のクラスのインスタンス化
    final purchase = PurchaseService();

    Future purchasePremium() async {
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      // 製品IDを取得して契約
      final String productID = await purchase.fetchProductID();
      final bool subscriptionCompleted = await purchase.subscribe(productID);
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

    return Column(children: <Widget>[
      Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: const Text(
            '2週間の無料お試しを始める',
            style: TextStyle(
                fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
          )),
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity,
              48), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
        ),
        onPressed: () => {purchasePremium()},
        icon: const Icon(Icons.grade, color: Colors.white),
        label: const Text(
          '¥500 / 月',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    ]);
  }
}
