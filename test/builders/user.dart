import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/consts/time_zone.dart';
import 'package:booqs_mobile/models/user.dart';

class UserBuilder {
  User build({
    bool premium = false,
    int langNumber = 41,
    int learningLangNumber = defaultLangNumber,
    bool appFavored = false,
  }) {
    return User(
        id: 1,
        publicUid: '117931',
        name: 'John Doe',
        email: 'test@booqs.net',
        langNumber: langNumber,
        learningLangNumber: learningLangNumber,
        timeZoneName: defaultTimeZone,
        mailDelivered: true,
        premium: premium,
        appFavored: appFavored,
        amountOfExp: 0,
        answerDaysCount: 0,
        answerHistoriesCount: 0,
        appCancelReportSent: false,
        continuousAnswerDaysCount: 0,
        continuousGoalAchievementCount: 0,
        continuousReviewCompletionCount: 0,
        paidViaNativeApp: false,
        reviewsCount: 0,
        rewardRemained: false,
        todaysAnswerHistoriesCount: 0,
        todaysCorrectAnswerHistoriesCount: 0,
        todaysTranslationsCount: 0,
        unreadNotificationsCount: 0,
        unsolvedReviewsCount: 0,
        unsolvedWeaknessesCount: 0,
        weaknessesCount: 0,
        wholeMonthAnswerHistoriesCount: 0,
        wholeWeekAnswerHistoriesCount: 0,
        drillsCount: 0,
        achievementMapsCount: 0,
        notesCount: 0);
  }
}
