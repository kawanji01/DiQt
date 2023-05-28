import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/answer_history.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/app_review_service.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/components/answer/answer_days_screen.dart';
import 'package:booqs_mobile/components/answer/requesting_review_screen.dart';
import 'package:booqs_mobile/components/answer/review_completion_screen.dart';
import 'package:booqs_mobile/components/answer/continuation_all_month_screen.dart';
import 'package:booqs_mobile/components/answer/continuation_all_week_screen.dart';
import 'package:booqs_mobile/components/answer/continuation_all_year_screen.dart';
import 'package:booqs_mobile/components/answer/continuous_answer_days_screen.dart';
import 'package:booqs_mobile/components/answer/continuous_review_completion_screen.dart';
import 'package:booqs_mobile/components/answer/continuous_goal_achievement_screen.dart';
import 'package:booqs_mobile/components/answer/drill_lap_clear_screen.dart';
import 'package:booqs_mobile/components/answer/goal_achievement_screen.dart';
import 'package:booqs_mobile/components/answer/weakness_clear_screen.dart';
import 'package:flutter/material.dart';

class AnswerReward {
  static Future<void> call(AnswerCreator answerCreator) async {
    // UnitTest で Dialogs の Mock を渡せるように、AnswerRewardでも Dialogs のインスタンスを外部から渡すようにする。
    final Dialogs dialogs = Dialogs();
    // 問題集周回報酬
    if (await AnswerReward.lapClear(answerCreator, dialogs)) {
      await delayed();
    }

    // 解答日数報酬
    if (await AnswerReward.answerDays(answerCreator, dialogs)) {
      await delayed();
    }

    // 連日解答報酬
    if (await AnswerReward.continuousAnswerDays(answerCreator, dialogs)) {
      await delayed();
    }

    // 連続週解答報酬
    if (await AnswerReward.continuationAllWeek(answerCreator, dialogs)) {
      await delayed();
    }

    // 連続月解答報酬
    if (await AnswerReward.continuationAllMonth(answerCreator, dialogs)) {
      await delayed();
    }

    // 連続年解答報酬
    if (await AnswerReward.continuationAllYear(answerCreator, dialogs)) {
      await delayed();
    }

    // 復習達成
    if (await AnswerReward.reviewCompletion(answerCreator, dialogs)) {
      await delayed();
    }

    // 連続復習達成
    if (await AnswerReward.continuousReviewCompletion(answerCreator, dialogs)) {
      await delayed();
    }

    // 目標達成
    if (await AnswerReward.goalAchievement(answerCreator, dialogs)) {
      await delayed();
    }

    // 連続目標達成
    if (await AnswerReward.continuousGoalAvhievement(answerCreator, dialogs)) {
      await delayed();
    }

    // 苦手な問題をすべて解答
    if (await AnswerReward.allWeaknessesSolved(answerCreator, dialogs)) {
      await delayed();
    }

    // 継続者にレビューを求める
    if (await AnswerReward.requestReview(
        answerCreator, dialogs, AppReviewService())) {
      await delayed();
    }
  }

  static Future<void> delayed() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  // 問題集周回報酬
  static Future<bool> lapClear(
      AnswerCreator answerCreator, Dialogs dialogs) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final DrillLap? drillLap = answerCreator.drillLap;

    if (drillLap != null && answerHistory!.atDrillPage && drillLap.cleared) {
      final Widget screen =
          AnswerDrillLapClearScreen(answerCreator: answerCreator);
      // await をつけると、このモーダルを閉じるまで次のモーダルを表示しなくなるので外しておく。
      dialogs.reward(screen);
      return true;
    } else {
      return false;
    }
  }

  // 解答日数報酬
  static Future<bool> answerDays(
      AnswerCreator answerCreator, Dialogs dialogs) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? answerDaysCount = answerCreator.answerDaysCount;
    if (answerHistory!.firstOfTheDay && answerDaysCount! > 0) {
      final Widget screen =
          AnswerAnswerDaysScreen(answerCreator: answerCreator);
      dialogs.reward(screen);
      return true;
    } else {
      return false;
    }
  }

  // 連日解答報酬
  static Future<bool> continuousAnswerDays(
      AnswerCreator answerCreator, Dialogs dialogs) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? continuousAnswerDaysCount =
        answerCreator.continuousAnswerDaysCount;
    if (answerHistory!.firstOfTheDay && continuousAnswerDaysCount! > 1) {
      final Widget screen =
          AnswerContinuousAnswerDaysScreen(answerCreator: answerCreator);
      dialogs.reward(screen);
      return true;
    } else {
      return false;
    }
  }

  // 連続週解答報酬
  static Future<bool> continuationAllWeek(
      AnswerCreator answerCreator, Dialogs dialogs) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? continuationAllWeekCount =
        answerCreator.continuationAllWeekCount;
    if (answerHistory!.continuationAllWeek && continuationAllWeekCount! > 0) {
      final Widget screen =
          AnswerContinuationAllWeekScreen(answerCreator: answerCreator);
      dialogs.reward(screen);
      return true;
    } else {
      return false;
    }
  }

  // 連続月解答報酬
  static Future<bool> continuationAllMonth(
      AnswerCreator answerCreator, Dialogs dialogs) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? continuationAllMonthCount =
        answerCreator.continuationAllMonthCount;
    if (answerHistory!.continuationAllMonth && continuationAllMonthCount! > 0) {
      final Widget screen =
          AnswerContinuationAllMonthScreen(answerCreator: answerCreator);
      dialogs.reward(screen);
      return true;
    } else {
      return false;
    }
  }

  // 連続年解答報酬
  static Future<bool> continuationAllYear(
      AnswerCreator answerCreator, Dialogs dialogs) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? continuationAllYearCount =
        answerCreator.continuationAllYearCount;
    if (answerHistory!.continuationAllYear && continuationAllYearCount! > 0) {
      final Widget screen =
          AnswerContinuationAllYearScreen(answerCreator: answerCreator);
      dialogs.reward(screen);
      return true;
    } else {
      return false;
    }
  }

  // 復習達成
  static Future<bool> reviewCompletion(
      AnswerCreator answerCreator, Dialogs dialogs) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final bool reviewCompletion = answerHistory!.reviewCompletion;
    if (reviewCompletion) {
      final Widget screen =
          AnswerReviewCompletionScreen(answerCreator: answerCreator);
      dialogs.reward(screen);
      return true;
    } else {
      return false;
    }
  }

  // 連続復習達成
  static Future<bool> continuousReviewCompletion(
      AnswerCreator answerCreator, Dialogs dialogs) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? continuousReviewCompletionCount =
        answerCreator.continuousReviewCompletionCount;
    final bool reviewCompletion = answerHistory!.reviewCompletion;
    if (reviewCompletion && continuousReviewCompletionCount! > 1) {
      final Widget screen =
          AnswerContinuousReviewCompletionScreen(answerCreator: answerCreator);
      dialogs.reward(screen);
      return true;
    } else {
      return false;
    }
  }

  // 目標達成報酬
  static Future<bool> goalAchievement(
      AnswerCreator answerCreator, Dialogs dialogs) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final bool goalAchievement = answerHistory!.goalAchievement;
    if (goalAchievement) {
      final Widget screen =
          AnswerGoalAchievementScreen(answerCreator: answerCreator);
      dialogs.reward(screen);
      return true;
    } else {
      return false;
    }
  }

  // 連続目標達成
  static Future<bool> continuousGoalAvhievement(
      AnswerCreator answerCreator, Dialogs dialogs) async {
    final AnswerHistory? answerHistory = answerCreator.answerHistory;
    final int? continuousGoalAchievementCount =
        answerCreator.continuousGoalAchievementCount;
    final bool goalAchievement = answerHistory!.goalAchievement;
    if (goalAchievement && continuousGoalAchievementCount! > 1) {
      final Widget screen =
          AnswerContinuousGoalAchievementScreen(answerCreator: answerCreator);
      dialogs.reward(screen);
      return true;
    } else {
      return false;
    }
  }

  // 苦手な問題をすべて解答
  static Future<bool> allWeaknessesSolved(
      AnswerCreator answerCreator, Dialogs dialogs) async {
    if (answerCreator.weaknessClear == true) {
      const Widget screen = AnswerWeaknessClearScreen();
      dialogs.reward(screen);
      return true;
    } else {
      return false;
    }
  }

  // 継続者にレビューを求める
  // 単体テストでmockを使えるように、AppReviewServiceのインスタンスを引数として渡す。
  static Future<bool> requestReview(AnswerCreator answerCreator,
      Dialogs dialogs, AppReviewService appReviewService) async {
    final User? user = answerCreator.user;
    if (user == null) return false;
    final int? answerDaysCount = answerCreator.answerDaysCount;
    if (answerDaysCount == null) return false;
    if (answerDaysCount < 10) return false;
    // 20日ごとにレビューを求める
    if (answerDaysCount % 20 != 0) return false;

    if (user.appFavored) {
      // アプリを気に入っている場合は、評価モーダルを表示する。
      await appReviewService.request();
    } else {
      // まだアプリを気に入っていない場合は、問い合わせフォームを含んだモーダルを表示する。
      dialogs.reward(const AnswerRequestingReviewScreen());
    }
    return true;
  }
}
