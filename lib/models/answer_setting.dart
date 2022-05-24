class AnswerSetting {
  AnswerSetting({
    required this.id,
    required this.userId,
    required this.intervalStepUpCondition,
    required this.initialInterval,
    required this.dailyGoal,
    required this.choicesCovered,
    required this.questionCovered,
    required this.reviewNotificationTimer,
    required this.reviewNotificationTimerSet,
    required this.reviewNotificationEnabled,
    required this.seEnabled,
    required this.effectEnabled,
    required this.speechRate,
    required this.reviewDeleteCondition,
    required this.weaknessCondition,
    required this.overcomingCondition,
    required this.createdAt,
    required this.updatedAt,
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
  bool effectEnabled;
  int speechRate;
  int reviewDeleteCondition;
  int weaknessCondition;
  int overcomingCondition;
  DateTime createdAt;
  DateTime updatedAt;

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
        effectEnabled = json['effect_enabled'],
        speechRate = json['speech_rate'],
        reviewDeleteCondition = json['review_delete_condition'],
        weaknessCondition = json['weakness_condition'],
        overcomingCondition = json['overcoming_condition'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);

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
        'effect_enabled': effectEnabled,
        'speech_rate': speechRate,
        'review_delete_condition': reviewDeleteCondition,
        'weakness_condition': weaknessCondition,
        'overcoming_condition': overcomingCondition,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
