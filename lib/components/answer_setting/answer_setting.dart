import 'package:booqs_mobile/components/answer_setting/daily_goal.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:booqs_mobile/components/answer_setting/choices_covered.dart';
import 'package:booqs_mobile/components/answer_setting/effect_enabled.dart';
import 'package:booqs_mobile/components/answer_setting/question_covered.dart';
import 'package:booqs_mobile/components/answer_setting/se_enabled.dart';
import 'package:booqs_mobile/components/answer_setting/strict_solving_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingAnswerSetting extends ConsumerWidget {
  const AnswerSettingAnswerSetting(
      {Key? key, required this.dailyGoalController})
      : super(key: key);
  final TextEditingController dailyGoalController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AnswerSetting? answerSetting = ref.watch(answerSettingProvider);
    if (answerSetting == null) return Container();

    final heding = RichText(
        text: TextSpan(children: [
      const WidgetSpan(
        child: Icon(
          Icons.settings,
          color: Colors.green,
          size: 30.0,
        ),
      ),
      TextSpan(
          text: ' ${t.answerSettings.answer_setting}',
          style: const TextStyle(
              color: Colors.green, fontSize: 28, fontWeight: FontWeight.bold))
    ]));

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        heding,
        const SizedBox(height: 32),
        AnswerSettingDailyGoal(
          dailyGoalController: dailyGoalController,
        ),
        const SizedBox(height: 48),
        const AnswerSettingStrictSolvingMode(),
        const SizedBox(height: 48),
        const AnswerSettingQuestionCovered(),
        const SizedBox(height: 48),
        const AnswerSettingChoicesCovered(),
        const SizedBox(height: 48),
        const AnswerSettingSEEnabled(),
        const SizedBox(height: 48),
        const AnswerSettingEffectEnabled(),
        const SizedBox(height: 48),
      ],
    );
  }
}
