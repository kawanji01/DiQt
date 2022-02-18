import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/services/purchase.dart';
import 'package:booqs_mobile/utils/booqs_on_web.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PurchaseDeleteButton extends StatelessWidget {
  const PurchaseDeleteButton({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    final purchase = PurchaseService();

    // 解約処理
    Future _cancelSubscription() async {
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: 'token');
      // 解約処理
      final subscriptionRestored = await purchase.deleteSubscriber(token);
      // 画面全体のローディングを消す。
      EasyLoading.dismiss();
      if (subscriptionRestored) {
        const snackBar = SnackBar(content: Text('プレミアムプランを解約しました。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
      } else {
        const snackBar = SnackBar(content: Text('解約に失敗しました。'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    // 解約ボタン
    Widget _cancelViaRevenueCat() {
      return GestureDetector(
        onTap: () async {
          const String title = '解約';
          const String text = 'プレミアムプランを解約します。よろしいですか？';
          bool result = await Dialogs.confirm(context, title, text);
          if (result) {
            await _cancelSubscription();
          }
        },
        child: const Text(
          '解約する',
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w400,
            color: Colors.red,
            fontSize: 14,
          ),
        ),
      );
    }

    Widget _cancelViaWeb() {
      return GestureDetector(
        onTap: () async {
          final String redirectPath = 'users/${user.publicUid}/payment_setting';
          BooQsOnWeb.open(context, redirectPath);
        },
        child: const Text(
          '解約する',
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w400,
            color: Colors.red,
            fontSize: 14,
          ),
        ),
      );
    }

    if (user.paidViaNativeApp == true) {
      return _cancelViaRevenueCat();
    } else {
      return _cancelViaWeb();
    }
  }
}
