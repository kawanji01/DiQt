import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:booqs_mobile/widgets/button/dialog_close_button.dart';
import 'package:flutter/material.dart';

class AnswerPaywallScreen extends StatelessWidget {
  const AnswerPaywallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const heading = Text('😵スタミナ切れ😵',
        style: TextStyle(
            fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange));
    const explanation = Text('無料プランで解けるのは、１日に１００問までです。',
        style: TextStyle(fontSize: 16, color: Colors.black87));

    Widget _premiumButton() {
      return Container(
        padding: const EdgeInsets.only(bottom: 16, right: 8, left: 8),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.pink,
              minimumSize: const Size(double.infinity,
                  48), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
            ),
            onPressed: () {
              PremiumPlanPage.push(context);
            },
            icon: const Icon(Icons.grade, color: Colors.white),
            label: const Text(
              'プレミアムプランを見る',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      );
    }

    return Container(
      height: 400,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // 閉じるボタンを下端に固定 ref: https://www.choge-blog.com/programming/flutter-bottom-button/
      child: Stack(
        children: [
          Column(children: [
            const SizedBox(height: 16),
            heading,
            const SizedBox(height: 16),
            explanation,
            const SizedBox(height: 32),
            _premiumButton(),
          ]),
          const DialogCloseButton(),
        ],
      ),
    );
  }
}
