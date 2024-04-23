import 'package:booqs_mobile/consts/time_zone.dart';

class DailyReport {
  DailyReport({
    this.id = 0,
    this.userId = 0,
    required this.measuredDate,
    this.rank,
    this.amountOfExp,
    this.answersCount,
    this.incorrectAnswersCount,
    this.answerDaysCount,
    this.continuationCount,
    this.allWeekContinuationCount,
    this.allMonthContinuationCount,
    this.allYearContinuationCount,
    required this.goalAchievement,
    required this.strictSolvingMode,
    this.continuousGoalAchievement,
    this.goalSetting,
    required this.reviewCompletion,
    required this.strictReviewingMode,
    this.continuousReviewComtpletionCount,
    this.reviewsCount,
    required this.timeZoneName,
    required this.createdAt,
    required this.updatedAt,
  });
  int id;
  int userId;
  DateTime measuredDate;
  int? rank;
  int? amountOfExp;
  int? answersCount;
  int? incorrectAnswersCount;
  int? answerDaysCount;
  int? continuationCount;
  int? allWeekContinuationCount;
  int? allMonthContinuationCount;
  int? allYearContinuationCount;
  bool goalAchievement;
  bool strictSolvingMode;
  int? continuousGoalAchievement;
  int? goalSetting;
  bool reviewCompletion;
  bool strictReviewingMode;
  int? continuousReviewComtpletionCount;
  int? reviewsCount;
  String timeZoneName;
  DateTime createdAt;
  DateTime updatedAt;

  DailyReport.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        measuredDate = DateTime.parse(json['measured_date']),
        rank = json['rank'],
        amountOfExp = json['amount_of_exp'],
        answersCount = json['answers_count'],
        incorrectAnswersCount = json['incorrect_answers_count'],
        answerDaysCount = json['answer_days_count'],
        continuationCount = json['continuation_count'],
        allWeekContinuationCount = json['all_week_continuation_count'],
        allMonthContinuationCount = json['all_month_continuation_Count'],
        allYearContinuationCount = json['all_year_continuation_count'],
        goalAchievement = json['goal_achievement'],
        strictSolvingMode = json['strict_solving_mode'],
        continuousGoalAchievement = json['continuous_goal_achievement'],
        goalSetting = json['goal_setting'],
        reviewCompletion = json['review_completion'],
        strictReviewingMode = json['strict_reviewing_mode'],
        continuousReviewComtpletionCount =
            json['continuous_review_comtpletion_count'],
        reviewsCount = json['reviews_count'],
        timeZoneName = json['time_zone_name'] ?? defaultTimeZone,
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'measured_date': measuredDate,
        'rank': rank,
        'amount_of_exp': amountOfExp,
        'answers_count': answersCount,
        'incorrect_answers_count': incorrectAnswersCount,
        'answer_days_count': answerDaysCount,
        'continuation_count': continuationCount,
        'all_week_continuation_count': allWeekContinuationCount,
        'all_month_continuation_Count': allMonthContinuationCount,
        'all_year_continuation_count': allYearContinuationCount,
        'goal_achievement': goalAchievement,
        'strict_solving_mode': strictSolvingMode,
        'continuous_goal_achievement': continuousGoalAchievement,
        'goal_setting': goalSetting,
        'review_completion': reviewCompletion,
        'strict_reviewing_mode': strictReviewingMode,
        'continuous_review_comtpletion_count': continuousReviewComtpletionCount,
        'reviews_count': reviewsCount,
        'time_zone_name': timeZoneName,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
