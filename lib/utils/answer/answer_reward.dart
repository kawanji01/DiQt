import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/answer_history.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/services/review_helper.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:booqs_mobile/widgets/answer/answer_days_screen.dart';
import 'package:booqs_mobile/widgets/answer/complete_review_screen.dart';
import 'package:booqs_mobile/widgets/answer/continuation_all_month_screen.dart';
import 'package:booqs_mobile/widgets/answer/continuation_all_week_screen.dart';
import 'package:booqs_mobile/widgets/answer/continuous_answer_days_screen.dart';
import 'package:booqs_mobile/widgets/answer/continuous_complete_review_screen.dart';
import 'package:booqs_mobile/widgets/answer/continuous_goal_achievement_screen.dart';
import 'package:booqs_mobile/widgets/answer/drill_lap_clear_screen.dart';
import 'package:booqs_mobile/widgets/answer/goal_achievement_screen.dart';
import 'package:flutter/material.dart';

class AnswerReward {
  static Future<void> call(
      BuildContext context, AnswerCreator answerCreator) async {
    // 問題集周回報酬
    await AnswerReward.lapClear(context, answerCreator);
    // 解答日数報酬
    await AnswerReward.answerDays(context, answerCreator);
    // 連日解答報酬
    await AnswerReward.continuousAnswerDays(context, answerCreator);
    // 連続週解答報酬
    await AnswerReward.continuationAllWeek(context, answerCreator);
    // 連続月解答報酬
    await AnswerReward.continuationAllMonth(context, answerCreator);
    // 復習達成
    await AnswerReward.completeReview(context, answerCreator);
    // 連続復習達成
    await AnswerReward.continuousCompleteReview(context, answerCreator);
    // 目標達成
    await AnswerReward.goalAchievement(context, answerCreator);
    // 連続目標達成
    await AnswerReward.continuousGoalAvhievement(context, answerCreator);
  }

  // 問題集周回報酬
  static Future<void> lapClear(
      BuildContext context, AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final DrillLap? drillLap = answerCreator.drillLap;
    if (answerHistory!.atDrillPage == false) return;
    if (drillLap == null) return;

    if (drillLap.clearLap) {
      final Widget screen =
          AnswerDrillLapClearScreen(answerCreator: answerCreator);
      await Dialogs.reward(context, screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // 解答日数報酬
  static Future<void> answerDays(
      BuildContext context, AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? answerDaysCount = answerCreator.answerDaysCount;
    if (answerHistory!.firstOfTheDay && answerDaysCount! > 0) {
      final Widget screen =
          AnswerAnswerDaysScreen(answerCreator: answerCreator);
      await Dialogs.reward(context, screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // 連日解答報酬
  static Future<void> continuousAnswerDays(
      BuildContext context, AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? continuousAnswerDaysCount =
        answerCreator.continuousAnswerDaysCount;
    if (answerHistory!.firstOfTheDay && continuousAnswerDaysCount! > 1) {
      final Widget screen =
          AnswerContinuousAnswerDaysScreen(answerCreator: answerCreator);
      await Dialogs.reward(context, screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // 連続週解答報酬
  static Future<void> continuationAllWeek(
      BuildContext context, AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? continuationAllWeekCount =
        answerCreator.continuationAllWeekCount;
    if (answerHistory!.continuationAllWeek && continuationAllWeekCount! > 0) {
      final Widget screen =
          AnswerContinuationAllWeekScreen(answerCreator: answerCreator);
      await Dialogs.reward(context, screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // 連続月解答報酬
  static Future<void> continuationAllMonth(
      BuildContext context, AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? continuationAllMonthCount =
        answerCreator.continuationAllMonthCount;
    if (answerHistory!.continuationAllMonth && continuationAllMonthCount! > 0) {
      final Widget screen =
          AnswerContinuationAllMonthScreen(answerCreator: answerCreator);
      await Dialogs.reward(context, screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // 復習達成
  static Future<void> completeReview(
      BuildContext context, AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    if (answerHistory!.completeReview) {
      final Widget screen =
          AnswerCompleteReviewScreen(answerCreator: answerCreator);
      await Dialogs.reward(context, screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // 連続復習達成
  static Future<void> continuousCompleteReview(
      BuildContext context, AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? continuousCompleteReviewCount =
        answerCreator.continuousCompleteReviewCount;
    if (answerHistory!.completeReview && continuousCompleteReviewCount! > 1) {
      final Widget screen =
          AnswerContinuousCompleteReviewScreen(answerCreator: answerCreator);
      await Dialogs.reward(context, screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // 目標達成報酬
  static Future<void> goalAchievement(
      BuildContext context, AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    if (answerHistory!.dailyGoalAchievement) {
      final Widget screen =
          AnswerGoalAchievementScreen(answerCreator: answerCreator);
      await Dialogs.reward(context, screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // 連続目標達成
  static Future<void> continuousGoalAvhievement(
      BuildContext context, AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? continuousGoalAchievementCount =
        answerCreator.continuousGoalAchievementCount;
    if (answerHistory!.dailyGoalAchievement &&
        continuousGoalAchievementCount! > 1) {
      final Widget screen =
          AnswerContinuousGoalAchievementScreen(answerCreator: answerCreator);
      await Dialogs.reward(context, screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }
}
