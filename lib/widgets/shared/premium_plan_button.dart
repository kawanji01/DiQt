import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/premium_menu.dart';
import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:flutter/material.dart';

class PremiumPlanButton extends StatelessWidget {
  const PremiumPlanButton({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    // プレミアムプランの紹介ページへ遷移するボタン
    Widget _premiumPlanButton() {
      return SizedBox(
        height: 40,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity,
                40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
          ),
          onPressed: () async {
            await PremiumPlanPage.push(context);
          },
          icon: const Icon(Icons.grade, color: Colors.white),
          label: const Text(
            'プレミアムプラン',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
    }

    // プレミアムプランに加入しているユーザーが利用できる機能のメニューを表示するボタン
    Widget _premiumMenuButton(user) {
      return SizedBox(
        height: 40,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity,
                40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
          ),
          onPressed: () async {
            await PremiumMenuPage.push(context, user);
          },
          icon: const Icon(Icons.grade, color: Colors.white),
          label: const Text(
            'プレミアムメニュー',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
    }

    // ボタンの表示
    Widget _button(user) {
      if (user.premium) {
        return _premiumMenuButton(user);
      }
      return _premiumPlanButton();
    }

    return _button(user);
  }
}
