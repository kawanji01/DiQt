import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:flutter/material.dart';

class SharedPremiumRecommendation extends StatelessWidget {
  const SharedPremiumRecommendation({Key? key, required this.explanationText})
      : super(key: key);
  final String explanationText;

  @override
  Widget build(BuildContext context) {
    final explanation = Text(
      explanationText,
      style: const TextStyle(color: Colors.black87, fontSize: 18),
    );

    final premiumButton = ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        minimumSize: const Size(double.infinity,
            48), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
      ),
      onPressed: () {
        PremiumPlanPage.push(context);
      },
      icon: const Icon(Icons.grade, color: Colors.white),
      label: const Text(
        'プレミアムプランを見る',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 48),
        explanation,
        const SizedBox(height: 16),
        premiumButton
      ],
    );
  }
}
