import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizAnswersCount extends ConsumerWidget {
  const QuizAnswersCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final int todaysAnswersCount = ref.watch(todaysAnswersCountProvider);
      final bool effectEnabled = ref.watch(effectEnabledProvider);
      if (effectEnabled == false) return;
      // １０問解答ごとに画面上端に通知を表示する。
      if (todaysAnswersCount % 10 == 0) {
        showFlash(
          context: context,
          duration: const Duration(seconds: 2),
          builder: (dialogContext, controller) {
            return FlashBar(
              controller: controller,
              position: FlashPosition.top,
              backgroundColor: Colors.black87,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18.0,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(t.answer.answers_count(count: todaysAnswersCount),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            );
          },
        );
      }
    });

    final int todaysAnswersCount = ref.watch(todaysAnswersCountProvider);
    final int todaysCorrectAnswersCount =
        ref.watch(todaysCorrectAnswersCountProvider);
    final int dailyGoalCount = ref.watch(
            answerSettingProvider.select((setting) => setting!.dailyGoal)) ??
        30;

    // 通常モードで表示する解答数
    Widget answersCount() {
      String message = '';
      if (dailyGoalCount < todaysAnswersCount) {
        message = '$todaysAnswersCount問解答';
      } else {
        final int remainedCount = dailyGoalCount - todaysAnswersCount;
        message = '目標まで残り$remainedCount問';
      }
      return Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      );
    }

    // 厳格解答モードで表示する解答数
    Widget correctAnswersCount() {
      String message = '';
      if (dailyGoalCount < todaysCorrectAnswersCount) {
        message = '$todaysCorrectAnswersCount問正解';
      } else {
        final int remainedCount = dailyGoalCount - todaysCorrectAnswersCount;
        message = '目標まで残り$remainedCount問正解';
      }
      return Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      );
    }

    Widget answersCountInformation() {
      final bool strictSolvingMode = ref.watch(strictSolvingModeProvider);
      if (strictSolvingMode) {
        return correctAnswersCount();
      }
      return answersCount();
    }

    return Container(
        padding: const EdgeInsets.only(bottom: 8),
        child: answersCountInformation());
  }
}
