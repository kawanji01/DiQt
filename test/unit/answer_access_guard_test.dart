import 'package:booqs_mobile/consts/validation.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/utils/answer/answer_access_guard.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  User buildUser(int id) {
    return User(
      id: id,
      publicUid: 'user-$id',
      name: 'User $id',
      email: 'user$id@example.com',
      langNumber: 44,
      learningLangNumber: 21,
      timeZoneName: 'Tokyo',
      mailDelivered: true,
      amountOfExp: 0,
      answerHistoriesCount: 0,
      todaysAnswerHistoriesCount: 0,
      todaysCorrectAnswerHistoriesCount: 0,
      wholeWeekAnswerHistoriesCount: 0,
      wholeMonthAnswerHistoriesCount: 0,
      answerDaysCount: 0,
      continuousAnswerDaysCount: 0,
      continuousGoalAchievementCount: 0,
      continuousReviewCompletionCount: 0,
      achievementMapsCount: 0,
      notesCount: 0,
      premium: false,
      paidViaNativeApp: false,
      unreadNotificationsCount: 0,
      unsolvedReviewsCount: 0,
      reviewsCount: 0,
      unsolvedWeaknessesCount: 0,
      weaknessesCount: 0,
      drillsCount: 0,
      rewardRemained: false,
      todaysTranslationsCount: 0,
      todaysAiSearchesCount: 0,
      appFavored: false,
      appCancelReportSent: false,
      langInitialized: true,
      reviewOnboardingShown: true,
      activated: true,
      authToken: 'token-$id',
    );
  }

  group('AnswerAccessGuard.freeAnswerLimitReached', () {
    test('returns true for free users at the daily answer limit', () {
      expect(
        AnswerAccessGuard.freeAnswerLimitReached(
          todaysAnswersCount: answersCountLimitForFreeUsers,
          premiumEnabled: false,
        ),
        isTrue,
      );
    });

    test('returns false for premium users', () {
      expect(
        AnswerAccessGuard.freeAnswerLimitReached(
          todaysAnswersCount: answersCountLimitForFreeUsers + 10,
          premiumEnabled: true,
        ),
        isFalse,
      );
    });

    test('returns false below the daily answer limit', () {
      expect(
        AnswerAccessGuard.freeAnswerLimitReached(
          todaysAnswersCount: answersCountLimitForFreeUsers - 1,
          premiumEnabled: false,
        ),
        isFalse,
      );
    });
  });

  group('AnswerAccessGuard.guardedTodaysAnswersCount', () {
    test('includes pending unsolved answers in the effective limit check', () {
      expect(
        AnswerAccessGuard.guardedTodaysAnswersCount(
          todaysAnswersCount: answersCountLimitForFreeUsers - 1,
          pendingUnsolvedAnswersCount: 1,
        ),
        answersCountLimitForFreeUsers,
      );
    });
  });

  group('pending answer scope', () {
    test(
        'keeps pending reservations and local count updates scoped to the active user',
        () {
      final ProviderContainer container = ProviderContainer();
      addTearDown(container.dispose);

      final User firstUser = buildUser(1);
      final User secondUser = buildUser(2);
      container.read(currentUserProvider.notifier).update(firstUser);
      container.read(todaysAnswersCountProvider.notifier).state = 3;
      container.read(todaysCorrectAnswersCountProvider.notifier).state = 1;

      AnswerAccessGuard.reserveUnsolvedAnswerFromContainer(
        container,
        userId: firstUser.id,
      );
      expect(container.read(pendingUnsolvedAnswersCountProvider), 1);

      container.read(currentUserProvider.notifier).update(secondUser);
      container.read(todaysAnswersCountProvider.notifier).state = 0;
      container.read(todaysCorrectAnswersCountProvider.notifier).state = 0;

      expect(container.read(pendingUnsolvedAnswersCountProvider), 0);

      AnswerAccessGuard.consumeReservedUnsolvedAnswerFromContainer(
        container,
        userId: firstUser.id,
        correct: true,
      );

      expect(container.read(pendingUnsolvedAnswersCountProvider), 0);
      expect(container.read(todaysAnswersCountProvider), 0);
      expect(container.read(todaysCorrectAnswersCountProvider), 0);
      expect(
          container.read(pendingUnsolvedAnswersCountByUserProvider), isEmpty);
    });
  });
}
