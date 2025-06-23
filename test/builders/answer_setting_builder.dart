import 'package:booqs_mobile/models/answer_setting.dart';

class AnswerSettingBuilder {
  static AnswerSetting build({
    int? id,
    int? userId,
    int? intervalStepUpCondition,
    int? initialInterval,
    int? dailyGoal,
    bool? choicesCovered,
    bool? questionCovered,
    bool? strictSolvingMode,
    int? reviewNotificationTimer,
    bool? reviewNotificationTimerSet,
    bool? reviewNotificationEnabled,
    bool? strictReviewingMode,
    bool? seEnabled,
    bool? effectEnabled,
    int? speechRate,
    int? reviewDeleteCondition,
    int? weaknessCondition,
    int? overcomingCondition,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    final now = DateTime.now();
    return AnswerSetting(
      id: id ?? 1,
      userId: userId ?? 1,
      intervalStepUpCondition: intervalStepUpCondition ?? 2,
      initialInterval: initialInterval ?? 1,
      dailyGoal: dailyGoal ?? 30,
      choicesCovered: choicesCovered ?? false,
      questionCovered: questionCovered ?? false,
      strictSolvingMode: strictSolvingMode ?? false,
      reviewNotificationTimer: reviewNotificationTimer ?? 12,
      reviewNotificationTimerSet: reviewNotificationTimerSet ?? false,
      reviewNotificationEnabled: reviewNotificationEnabled ?? false,
      strictReviewingMode: strictReviewingMode ?? false,
      seEnabled: seEnabled ?? true,
      effectEnabled: effectEnabled ?? true,
      speechRate: speechRate ?? 50,
      reviewDeleteCondition: reviewDeleteCondition ?? 7,
      weaknessCondition: weaknessCondition ?? 3,
      overcomingCondition: overcomingCondition ?? 80,
      createdAt: createdAt ?? now,
      updatedAt: updatedAt ?? now,
    );
  }
}