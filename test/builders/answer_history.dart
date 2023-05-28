import 'package:booqs_mobile/models/answer_history.dart';

class AnswerHistoryBuilder {
  AnswerHistory build(
      {bool atDrillPage = false,
      bool atReviewPage = false,
      bool atWeknessPage = false}) {
    return AnswerHistory(
      atDrillPage: true,
      atReviewPage: false,
      atWeknessPage: false,
      id: 1,
      userId: 1,
      drillId: 0,
      quizId: 0,
      answerAnalysisId: 1,
      correct: false,
      answerDate: DateTime.now(),
      continuation: false,
      continuationAllMonth: false,
      continuationAllWeek: false,
      continuationAllYear: false,
      firstOfTheDay: false,
      goalAchievement: false,
      holiday: false,
      intervalStepUp: false,
      reviewCompletion: false,
      updatedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );
  }
}
