import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/models/answer_history.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/models/review.dart';

class AnswerCreator {
  AnswerCreator({
    this.answerHistory,
    this.answerAnalysis,
    this.review,
    this.drillLap,
    this.todaysAnswerHistoriesCount,
    this.solvedQuizzesCount,
    this.unsolvedReviewsCount,
    this.answerDaysCount,
    this.continuousAnswerDaysCount,
    this.continuationAllWeekCount,
    this.continuationAllMonthCount,
    this.continuationAllYearCount,
    this.continuousGoalAchievementCount,
    this.continuousCompleteReviewCount,
    this.reviewCreated = false,
    this.reviewReleased = false,
    this.sameMistakeCount,
    this.overcoming = false,
    this.basePoint = 0,
    this.answerPoint = 0,
    this.startPoint = 0,
    this.lapClearPoint = 0,
    this.answerDaysPoint = 0,
    this.continuousAnswerDaysPoint = 0,
    this.continuationAllWeekPoint = 0,
    this.continuationAllMonthPoint = 0,
    this.continuationAllYearPoint = 0,
    this.completeReviewPoint = 0,
    this.continuousCompleteReviewPoint = 0,
    this.goalAchievementPoint = 0,
    this.continuousGoalAchievementPoint = 0,
    this.allPoint = 0,
  });

  AnswerHistory? answerHistory;
  AnswerAnalysis? answerAnalysis;
  Review? review;
  DrillLap? drillLap;
  int? todaysAnswerHistoriesCount;
  int? solvedQuizzesCount;
  int? unsolvedReviewsCount;
  int? answerDaysCount;
  int? continuousAnswerDaysCount;
  int? continuationAllWeekCount;
  int? continuationAllMonthCount;
  int? continuationAllYearCount;
  int? continuousGoalAchievementCount;
  int? continuousCompleteReviewCount;
  bool? reviewCreated;
  bool? reviewReleased;
  int? sameMistakeCount;
  bool? overcoming;
  int basePoint;
  int answerPoint;
  int startPoint;
  int lapClearPoint;
  int answerDaysPoint;
  int continuousAnswerDaysPoint;
  int continuationAllWeekPoint;
  int continuationAllMonthPoint;
  int continuationAllYearPoint;
  int completeReviewPoint;
  int continuousCompleteReviewPoint;
  int goalAchievementPoint;
  int continuousGoalAchievementPoint;
  int allPoint;

  AnswerCreator.fromJson(Map<String, dynamic> json)
      : answerHistory = json['answer_history'] == null
            ? null
            : AnswerHistory.fromJson(json['answer_history']),
        answerAnalysis = json['answer_analysis'] == null
            ? null
            : AnswerAnalysis.fromJson(json['answer_analysis']),
        review =
            json['review'] == null ? null : Review.fromJson(json['review']),
        drillLap = json['drill_lap'] == null
            ? null
            : DrillLap.fromJson(json['drill_lap']),
        todaysAnswerHistoriesCount = json['todays_answer_histories_count'],
        solvedQuizzesCount = json['solved_quizzes_count'],
        unsolvedReviewsCount = json['unsolved_reviews_count'],
        answerDaysCount = json['answer_days_count'],
        continuousAnswerDaysCount = json['continuous_answer_days_count'],
        continuationAllWeekCount = json['continuation_all_week_count'],
        continuationAllMonthCount = json['continuation_all_month_count'],
        continuationAllYearCount = json['continuation_all_year_count'],
        continuousGoalAchievementCount =
            json['continuous_goal_achievement_count'],
        continuousCompleteReviewCount =
            json['continuous_complete_review_count'],
        reviewCreated = json['review_created'],
        reviewReleased = json['review_released'],
        sameMistakeCount = json['same_mistake_count'],
        overcoming = json['overcoming'],
        basePoint = json['base_point'],
        answerPoint = json['answer_point'],
        startPoint = json['start_point'],
        lapClearPoint = json['lap_clear_point'],
        answerDaysPoint = json['answer_days_point'],
        continuousAnswerDaysPoint = json['continuous_answer_days_point'],
        continuationAllWeekPoint = json['continuation_all_week_point'],
        continuationAllMonthPoint = json['continuation_all_month_point'],
        continuationAllYearPoint = json['continuation_all_year_point'],
        completeReviewPoint = json['complete_review_point'],
        continuousCompleteReviewPoint =
            json['continuous_complete_review_point'],
        goalAchievementPoint = json['goal_achievement_point'],
        continuousGoalAchievementPoint =
            json['continuous_goal_achievement_point'],
        allPoint = json['all_point'];

  Map<String, dynamic> toJson() => {
        'answer_history': answerHistory,
        'answer_analysis': answerAnalysis,
        'review': review,
        'drillLap': drillLap,
        'todays_answer_histories_count': todaysAnswerHistoriesCount,
        'solved_quizzes_count': solvedQuizzesCount,
        'unsolved_reviews_count': unsolvedReviewsCount,
        'answer_days_count': answerDaysCount,
        'continuous_answer_days_count': continuousAnswerDaysCount,
        'continuation_all_week_count': continuationAllWeekCount,
        'continuation_all_month_count': continuationAllMonthCount,
        'continuation_all_year_count': continuationAllYearCount,
        'continuous_goal_achievement_count': continuousGoalAchievementCount,
        'continuous_complete_review_count': continuousCompleteReviewCount,
        'review_created': reviewCreated,
        'review_released': reviewReleased,
        'same_mistake_count': sameMistakeCount,
        'overcoming': overcoming,
        'base_point': basePoint,
        'answer_point': answerPoint,
        'start_point': startPoint,
        'lap_clear_point': lapClearPoint,
        'answer_days_point': answerDaysPoint,
        'continuous_answer_days_point': continuousAnswerDaysPoint,
        'continuation_all_week_point': continuationAllWeekPoint,
        'continuation_all_month_point': continuationAllMonthPoint,
        'continuation_all_year_point': continuationAllYearPoint,
        'complete_review_point': completeReviewPoint,
        'continuous_complete_review_point': continuousCompleteReviewPoint,
        'goal_achievement_point': answerDaysPoint,
        'continuous_goal_achievement_point': continuousGoalAchievementPoint,
        'all_point': allPoint,
      };
}
