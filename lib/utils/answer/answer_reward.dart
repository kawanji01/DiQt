import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/answer_history.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/app_review_service.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/widgets/answer/answer_days_screen.dart';
import 'package:booqs_mobile/widgets/answer/requesting_review_screen.dart';
import 'package:booqs_mobile/widgets/answer/review_completion_screen.dart';
import 'package:booqs_mobile/widgets/answer/continuation_all_month_screen.dart';
import 'package:booqs_mobile/widgets/answer/continuation_all_week_screen.dart';
import 'package:booqs_mobile/widgets/answer/continuation_all_year_screen.dart';
import 'package:booqs_mobile/widgets/answer/continuous_answer_days_screen.dart';
import 'package:booqs_mobile/widgets/answer/continuous_review_completion_screen.dart';
import 'package:booqs_mobile/widgets/answer/continuous_goal_achievement_screen.dart';
import 'package:booqs_mobile/widgets/answer/drill_lap_clear_screen.dart';
import 'package:booqs_mobile/widgets/answer/goal_achievement_screen.dart';
import 'package:booqs_mobile/widgets/answer/weakness_clear_screen.dart';
import 'package:flutter/material.dart';

class AnswerReward {
  static Future<void> call(AnswerCreator answerCreator) async {
    // 問題集周回報酬
    await AnswerReward.lapClear(answerCreator);
    // 解答日数報酬
    await AnswerReward.answerDays(answerCreator);
    // 連日解答報酬
    await AnswerReward.continuousAnswerDays(answerCreator);
    // 連続週解答報酬
    await AnswerReward.continuationAllWeek(answerCreator);
    // 連続月解答報酬
    await AnswerReward.continuationAllMonth(answerCreator);
    // 連続年解答報酬
    await AnswerReward.continuationAllYear(answerCreator);
    // 復習達成
    await AnswerReward.reviewCompletion(answerCreator);
    // 連続復習達成
    await AnswerReward.continuousReviewCompletion(answerCreator);
    // 目標達成
    await AnswerReward.goalAchievement(answerCreator);
    // 連続目標達成
    await AnswerReward.continuousGoalAvhievement(answerCreator);
    // 苦手な問題をすべて解答
    await AnswerReward.allWeaknessesSolved(answerCreator);
    // 継続者にレビューを求める
    await AnswerReward.requestReview(answerCreator);
  }

  // 問題集周回報酬
  static Future<void> lapClear(AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final DrillLap? drillLap = answerCreator.drillLap;

    if (drillLap != null && answerHistory!.atDrillPage && drillLap.cleared) {
      final Widget screen =
          AnswerDrillLapClearScreen(answerCreator: answerCreator);
      Dialogs.reward(screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // 解答日数報酬
  static Future<void> answerDays(AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? answerDaysCount = answerCreator.answerDaysCount;
    if (answerHistory!.firstOfTheDay && answerDaysCount! > 0) {
      final Widget screen =
          AnswerAnswerDaysScreen(answerCreator: answerCreator);
      Dialogs.reward(screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // 連日解答報酬
  static Future<void> continuousAnswerDays(AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? continuousAnswerDaysCount =
        answerCreator.continuousAnswerDaysCount;
    if (answerHistory!.firstOfTheDay && continuousAnswerDaysCount! > 1) {
      final Widget screen =
          AnswerContinuousAnswerDaysScreen(answerCreator: answerCreator);
      Dialogs.reward(screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // 連続週解答報酬
  static Future<void> continuationAllWeek(AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? continuationAllWeekCount =
        answerCreator.continuationAllWeekCount;
    if (answerHistory!.continuationAllWeek && continuationAllWeekCount! > 0) {
      final Widget screen =
          AnswerContinuationAllWeekScreen(answerCreator: answerCreator);
      Dialogs.reward(screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // 連続月解答報酬
  static Future<void> continuationAllMonth(AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? continuationAllMonthCount =
        answerCreator.continuationAllMonthCount;
    if (answerHistory!.continuationAllMonth && continuationAllMonthCount! > 0) {
      final Widget screen =
          AnswerContinuationAllMonthScreen(answerCreator: answerCreator);
      Dialogs.reward(screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // 連続年解答報酬
  static Future<void> continuationAllYear(AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? continuationAllYearCount =
        answerCreator.continuationAllYearCount;
    if (answerHistory!.continuationAllYear && continuationAllYearCount! > 0) {
      final Widget screen =
          AnswerContinuationAllYearScreen(answerCreator: answerCreator);
      Dialogs.reward(screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // 復習達成
  static Future<void> reviewCompletion(AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final bool reviewCompletion = answerHistory!.reviewCompletion;
    if (reviewCompletion) {
      final Widget screen =
          AnswerReviewCompletionScreen(answerCreator: answerCreator);
      Dialogs.reward(screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // 連続復習達成
  static Future<void> continuousReviewCompletion(
      AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? continuousReviewCompletionCount =
        answerCreator.continuousReviewCompletionCount;
    final bool reviewCompletion = answerHistory!.reviewCompletion;
    if (reviewCompletion && continuousReviewCompletionCount! > 1) {
      final Widget screen =
          AnswerContinuousReviewCompletionScreen(answerCreator: answerCreator);
      Dialogs.reward(screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // 目標達成報酬
  static Future<void> goalAchievement(AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final bool goalAchievement = answerHistory!.goalAchievement;
    if (goalAchievement) {
      final Widget screen =
          AnswerGoalAchievementScreen(answerCreator: answerCreator);
      Dialogs.reward(screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // 連続目標達成
  static Future<void> continuousGoalAvhievement(
      AnswerCreator answerCreator) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? continuousGoalAchievementCount =
        answerCreator.continuousGoalAchievementCount;
    final bool goalAchievement = answerHistory!.goalAchievement;
    if (goalAchievement && continuousGoalAchievementCount! > 1) {
      final Widget screen =
          AnswerContinuousGoalAchievementScreen(answerCreator: answerCreator);
      Dialogs.reward(screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // 苦手な問題をすべて解答
  static Future<void> allWeaknessesSolved(AnswerCreator answerCreator) async {
    if (answerCreator.weaknessClear == true) {
      const Widget screen = AnswerWeaknessClearScreen();
      Dialogs.reward(screen);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // 継続者にレビューを求める
  static Future<void> requestReview(AnswerCreator answerCreator) async {
    final User? user = answerCreator.user;
    if (user == null) return;
    final int? answerDaysCount = answerCreator.answerDaysCount;
    if (answerDaysCount == null) return;
    if (answerDaysCount < 10) return;
    // 20日ごとにレビューを求める
    if (answerDaysCount % 20 != 0) return;

    if (user.appFavored) {
      // アプリを気に入っている場合は、評価モーダルを表示する。
      await AppReviewService.request();
    } else {
      // まだアプリを気に入っていない場合は、問い合わせフォームを含んだモーダルを表示する。
      Dialogs.reward(const AnswerRequestingReviewScreen());
    }
    await Future.delayed(const Duration(seconds: 2));
  }
}
