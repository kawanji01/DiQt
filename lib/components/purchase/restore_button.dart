import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/utils/purchase_service.dart';
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
        if (!context.mounted) return;
        if (subscriptionRestored) {
          final snackBar = SnackBar(content: Text(t.purchase.restore_success));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          UserMyPage.push(context);
        } else {
          final snackBar = SnackBar(content: Text(t.purchase.restore_error));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Text(
        t.purchase.restore,
        style: const TextStyle(
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
    );
  }
}
