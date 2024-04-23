import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerSettingDailyGoal extends ConsumerWidget {
  const AnswerSettingDailyGoal({super.key, required this.dailyGoalController});
  final TextEditingController dailyGoalController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int todaysAnswersCount = ref.watch(todaysAnswersCountProvider);
    final int goalCount = ref
        .watch(answerSettingProvider.select((value) => value?.dailyGoal ?? 0));

    // 何度も目標達成してしまうのを防ぐために、目標を超えて解答している場合には目標を変更できないようにする。
    if (goalCount < todaysAnswersCount) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextField(
          enabled: false,
          controller: dailyGoalController,
          decoration: InputDecoration(labelText: t.answerSettings.daily_goal),
          keyboardType: const TextInputType.numberWithOptions(signed: true),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          t.answerSettings.daily_goal_cant_be_changed,
          style: const TextStyle(color: Colors.red),
        )
      ]);
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextField(
        controller: dailyGoalController,
        decoration: InputDecoration(
          labelText: t.answerSettings.daily_goal,
        ),
        keyboardType: const TextInputType.numberWithOptions(signed: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        t.answerSettings.daily_goal_description,
        style: const TextStyle(color: Colors.black54),
      )
    ]);
  }
}
