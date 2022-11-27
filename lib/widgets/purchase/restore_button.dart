import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/services/purchase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// サブスクのリストアボタン
class PurchaseRestoreButton extends StatefulWidget {
  const PurchaseRestoreButton({Key? key}) : super(key: key);

  @override
  State<PurchaseRestoreButton> createState() => _PurchaseRestoreButtonState();
}

class _PurchaseRestoreButtonState extends State<PurchaseRestoreButton> {
  @override
  Widget build(BuildContext context) {
    final purchase = PurchaseService();
    return GestureDetector(
      onTap: () async {
        // 画面全体にローディングを表示
        EasyLoading.show(status: 'loading...');
        // リストア処理
        final subscriptionRestored = await purchase.restore();
        // 画面全体のローディングを消す。
        EasyLoading.dismiss();
        if (!mounted) return;
        if (subscriptionRestored) {
          const snackBar = SnackBar(content: Text('購入情報を復元しました。'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          UserMyPage.push(context);
        } else {
          const snackBar = SnackBar(content: Text('復元できる購入情報がありません。'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: const Text(
        '以前購入した方はこちら',
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
    );
  }
}
