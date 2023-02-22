import 'package:booqs_mobile/pages/user/premium_plan.dart';
import 'package:flutter/material.dart';

class LangSmallTranslationOverLimit extends StatelessWidget {
  const LangSmallTranslationOverLimit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle styleText = TextStyle(fontSize: 14, color: Colors.black87);

    void recommendPremiumPlan() {
      const snackBar = SnackBar(content: Text('無料ユーザーの利用できる翻訳回数は、1日に10件までです。'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      PremiumPlanPage.push(context);
    }

    return Row(
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () => recommendPremiumPlan(),
          child: const Text('Google翻訳', style: TextStyle(color: Colors.green)),
        ),
        const Text(
          ' / ',
          style: styleText,
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () => recommendPremiumPlan(),
          child: const Text('DeepL翻訳', style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }
}
