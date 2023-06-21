import 'package:booqs_mobile/components/shared/premium_recommendation.dart';
import 'package:booqs_mobile/consts/validation.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/button/dialog_close_button.dart';
import 'package:flutter/material.dart';

class AnswerPaywallScreen extends StatelessWidget {
  const AnswerPaywallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveValues.dialogHeight(context),
      width: ResponsiveValues.dialogWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // 閉じるボタンを下端に固定 ref: https://www.choge-blog.com/programming/flutter-bottom-button/
      child: Stack(
        children: [
          Column(children: [
            const SizedBox(height: 16),
            // heading
            Text(t.answer.limit_reached,
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
            const SizedBox(height: 24),
            SharedPremiumRecommendation(
              description: t.answer.limit_reached_description(
                  number: answersCountLimitForFreeUsers),
            ),
          ]),
          const DialogCloseButton(),
        ],
      ),
    );
  }
}
