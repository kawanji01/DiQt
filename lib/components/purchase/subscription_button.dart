import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/purchase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        final snackBar = SnackBar(content: Text(t.purchase.purchase_succeded));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
      }
    }

    return Column(children: <Widget>[
      /*  Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            t.purchase.trial_period_description,
            style: const TextStyle(
                fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
          )), */
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity,
              48), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
        ),
        onPressed: () => {purchasePremium()},
        icon: const FaIcon(
          FontAwesomeIcons.crown,
          size: 22,
          color: Colors.white,
        ),
        label: Text(
          t.purchase.monthly_plan_price,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    ]);
  }
}
