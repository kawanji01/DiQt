class AnswerHistory {
  AnswerHistory({
    this.id,
    this.userId,
    this.quizId,
    this.drillId,
    this.answerAnalysisId,
    this.correct = false,
    this.atDrillPage = false,
    this.atReviewPage = false,
    this.atWeknessPage = false,
    this.intervalStepUp = false,
    this.answerDate,
    this.firstOfTheDay = false,
    this.answer,
    //this.solved = false,
    this.dailyGoalAchievement = false,
    this.completeReview = false,
    this.continuation = false,
    this.continuationAllWeek = false,
    this.continuationAllMonth = false,
    this.continuationAllYear = false,
    this.holiday = false,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  int? quizId;
  int? drillId;
  int? answerAnalysisId;
  bool correct;
  bool atDrillPage;
  bool atReviewPage;
  bool atWeknessPage;
  bool intervalStepUp;
  String? answerDate;
  bool firstOfTheDay;
  String? answer;
  // bool solved;
  bool dailyGoalAchievement;
  bool completeReview;
  bool continuation;
  bool continuationAllWeek;
  bool continuationAllMonth;
  bool continuationAllYear;
  bool holiday;
  String? createdAt;
  String? updatedAt;

  AnswerHistory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        quizId = json['quiz_id'],
        drillId = json['drill_id'],
        answerAnalysisId = json['answer_analysis_id'],
        correct = json['correct'],
        atDrillPage = json['at_drill_page'],
        atReviewPage = json['at_review_page'],
        atWeknessPage = json['at_weakness_page'],
        intervalStepUp = json['interval_step_up'],
        answerDate = json['answer_date'],
        firstOfTheDay = json['first_of_the_day'],
        answer = json['answer'],
        dailyGoalAchievement = json['daily_goal_achievement'],
        completeReview = json['complete_review'],
        continuation = json['continuation'],
        continuationAllWeek = json['continuation_all_week'],
        continuationAllMonth = json['continuation_all_month'],
        continuationAllYear = json['continuation_all_year'],
        holiday = json['holiday'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'quiz_id': quizId,
        'drill_id': drillId,
        'answer_analysis_id': answerAnalysisId,
        'correct': correct,
        'at_drill_page': atDrillPage,
        'at_review_page': atReviewPage,
        'at_wekness_page': atWeknessPage,
        'interval_step_up': intervalStepUp,
        'answer_date': answerDate,
        'first_of_the_day': firstOfTheDay,
        'answer': answer,
        'daily_goal_achievement': dailyGoalAchievement,
        'complete_review': completeReview,
        'continuation': continuation,
        'continuation_all_week': continuationAllWeek,
        'continuation_all_month': continuationAllMonth,
        'continuation_all_year': continuationAllYear,
        'holiday': holiday,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
