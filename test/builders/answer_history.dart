import 'package:booqs_mobile/consts/time_zone.dart';
import 'package:booqs_mobile/models/answer_history.dart';

class AnswerHistoryBuilder {
  AnswerHistory build(
      {bool correct = false,
      bool atDrillPage = false,
      bool atReviewPage = false,
      bool atWeknessPage = false,
      bool firstOfTheDay = false,
      bool reviewCompletion = false,
      bool goalAchievement = false,
      bool continuation = false,
      bool continuationAllWeek = false,
      bool continuationAllMonth = false,
      bool continuationAllYear = false}) {
    return AnswerHistory(
      correct: correct,
      atDrillPage: atDrillPage,
      atReviewPage: atReviewPage,
      atWeknessPage: atWeknessPage,
      firstOfTheDay: firstOfTheDay,
      continuation: continuation,
      reviewCompletion: reviewCompletion,
      goalAchievement: goalAchievement,
      continuationAllWeek: continuationAllWeek,
      continuationAllMonth: continuationAllMonth,
      continuationAllYear: continuationAllYear,
      id: 1,
      userId: 1,
      drillId: 0,
      quizId: 0,
      answerAnalysisId: 1,
      answerDate: DateTime.now(),
      intervalStepUp: false,
      timeZoneName: defaultTimeZone,
      updatedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );
  }
}
