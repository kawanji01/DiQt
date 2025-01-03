import 'package:booqs_mobile/components/answer_setting/overcoming_condition.dart';
import 'package:booqs_mobile/components/answer_setting/weakness_condition.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingWeaknessSetting extends ConsumerWidget {
  const AnswerSettingWeaknessSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heding = RichText(
        text: TextSpan(children: [
      const WidgetSpan(
        child: Icon(
          Icons.check_circle_outline,
          color: Colors.green,
          size: 30.0,
        ),
      ),
      TextSpan(
          text: ' ${t.answerSettings.weakness_setting}',
          style: const TextStyle(
              color: Colors.green, fontSize: 28, fontWeight: FontWeight.bold))
    ]));

    return Column(
      children: [
        heding,
        const SizedBox(height: 32),
        const AnswerSettingWeaknessCondition(),
        const SizedBox(height: 48),
        const AnswerSettingOvercomingCondition(),
        const SizedBox(height: 48),
      ],
    );
  }
}
