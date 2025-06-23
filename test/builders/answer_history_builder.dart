import 'package:booqs_mobile/models/answer_history.dart';

class AnswerHistoryBuilder {
  static AnswerHistory build({
    int? id,
    int? userId,
    int? quizId,
    int? drillId,
    int? answerAnalysisId,
    bool? correct,
    bool? atDrillPage,
    bool? atReviewPage,
    bool? atWeknessPage,
    bool? intervalStepUp,
    DateTime? answerDate,
    bool? firstOfTheDay,
    bool? goalAchievement,
    bool? reviewCompletion,
    bool? continuation,
    bool? continuationAllWeek,
    bool? continuationAllMonth,
    bool? continuationAllYear,
    String? timeZoneName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    final now = DateTime.now();
    return AnswerHistory(
      id: id ?? 1,
      userId: userId ?? 1,
      quizId: quizId ?? 1,
      drillId: drillId ?? 1,
      answerAnalysisId: answerAnalysisId ?? 1,
      correct: correct ?? true,
      atDrillPage: atDrillPage ?? false,
      atReviewPage: atReviewPage ?? false,
      atWeknessPage: atWeknessPage ?? false,
      intervalStepUp: intervalStepUp ?? false,
      answerDate: answerDate ?? now,
      firstOfTheDay: firstOfTheDay ?? false,
      goalAchievement: goalAchievement ?? false,
      reviewCompletion: reviewCompletion ?? false,
      continuation: continuation ?? false,
      continuationAllWeek: continuationAllWeek ?? false,
      continuationAllMonth: continuationAllMonth ?? false,
      continuationAllYear: continuationAllYear ?? false,
      timeZoneName: timeZoneName ?? 'UTC',
      createdAt: createdAt ?? now,
      updatedAt: updatedAt ?? now,
    );
  }
}