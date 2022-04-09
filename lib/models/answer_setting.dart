class AnswerSetting {
  AnswerSetting({
    this.id = 0,
    this.userId = 0,
    this.intervalStepUpCondition = 1,
    this.initialInterval = 1,
    this.dailyGoal = 30,
    this.choicesCovered = false,
    this.questionCovered = false,
    this.reviewNotificationTimer = 6,
    this.reviewNotificationTimerSet = false,
    this.reviewNotificationEnabled = true,
    this.seEnabled = true,
    this.speechRate = 1,
    this.reviewDeleteCondition = 0,
    this.weaknessCondition = 2,
    this.overcomingCondition = 2,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  int intervalStepUpCondition;
  int initialInterval;
  int dailyGoal;
  bool choicesCovered;
  bool questionCovered;
  int reviewNotificationTimer;
  bool reviewNotificationTimerSet;
  bool reviewNotificationEnabled;
  bool seEnabled;
  int speechRate;
  int reviewDeleteCondition;
  int weaknessCondition;
  int overcomingCondition;
  String? createdAt;
  String? updatedAt;

  AnswerSetting.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        intervalStepUpCondition = json['interval_step_up_condition'],
        initialInterval = json['initial_interval'],
        dailyGoal = json['daily_goal'],
        choicesCovered = json['choices_covered'],
        questionCovered = json['question_covered'],
        reviewNotificationTimer = json['review_notification_timer'],
        reviewNotificationTimerSet = json['review_notification_timer_set'],
        reviewNotificationEnabled = json['review_notification_enabled'],
        seEnabled = json['se_enabled'],
        speechRate = json['speech_rate'],
        reviewDeleteCondition = json['review_delete_condition'],
        weaknessCondition = json['weakness_condition'],
        overcomingCondition = json['overcoming_condition'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'interval_step_up_condition': intervalStepUpCondition,
        'initial_interval': initialInterval,
        'daily_goal': dailyGoal,
        'choices_covered': choicesCovered,
        'question_covered': questionCovered,
        'review_notification_timer': reviewNotificationTimer,
        'review_notification_timer_set': reviewNotificationTimerSet,
        'review_notification_enabled': reviewNotificationEnabled,
        'se_enabled': seEnabled,
        'speech_rate': speechRate,
        'review_delete_condition': reviewDeleteCondition,
        'weakness_condition': weaknessCondition,
        'overcoming_condition': overcomingCondition,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
