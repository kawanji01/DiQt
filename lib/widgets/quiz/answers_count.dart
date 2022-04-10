import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/todays_answers_count.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizAnswersCount extends ConsumerWidget {
  const QuizAnswersCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final int todaysAnswersCount = ref.watch(todaysAnswersCountProvider);
      if (todaysAnswersCount % 10 == 0) {
        showFlash(
          context: context,
          duration: const Duration(seconds: 2),
          builder: (context, controller) {
            // ref: https://resocoder.com/2021/01/30/snackbar-toast-dialog-in-flutter-flash-package/
            // ref: https://itnext.io/highly-customizable-toast-dialog-snackbar-in-flutter-2c27e533dd63
            return Flash(
              controller: controller,
              barrierDismissible: false,
              alignment: Alignment.topCenter,
              borderRadius: BorderRadius.circular(12),
              backgroundColor: Colors.black87,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  "$todaysAnswersCount問解答",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        );
      }
    });

    Widget _answersCount() {
      final int todaysAnswersCount = ref.watch(todaysAnswersCountProvider);
      final int dailyGoalCount = ref.watch(
              answerSettingProvider.select((setting) => setting!.dailyGoal)) ??
          30;
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

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: _answersCount());
  }
}
