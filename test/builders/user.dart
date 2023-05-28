import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/models/user.dart';

class UserBuilder {
  User build(
      {bool premium = false,
      int langNumber = 41,
      int learningLangNumber = defaultLangNumber}) {
    return User(
        id: 1,
        publicUid: '117931',
        name: 'John Doe',
        langNumber: langNumber,
        learningLangNumber: learningLangNumber,
        premium: premium,
        achievementMapsCount: 0,
        amountOfExp: 0,
        answerDaysCount: 0,
        answerHistoriesCount: 0,
        appCancelReportSent: false,
        appFavored: false,
        continuousAnswerDaysCount: 0,
        continuousGoalAchievementCount: 0,
        continuousReviewCompletionCount: 0,
        paidViaNativeApp: false,
        reviewsCount: 0,
        rewardRemained: false,
        school: false,
        todaysAnswerHistoriesCount: 0,
        todaysCorrectAnswerHistoriesCount: 0,
        todaysTranslationsCount: 0,
        unreadNotificationsCount: 0,
        unsolvedReviewsCount: 0,
        unsolvedWeaknessesCount: 0,
        weaknessesCount: 0,
        wholeMonthAnswerHistoriesCount: 0,
        wholeMonthsAnswerHistoriesCount: 0,
        wholeWeekAnswerHistoriesCount: 0,
        wholeWeeksAnswerHistoriesCount: 0);
  }
}
