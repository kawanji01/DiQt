import 'package:booqs_mobile/components/answer/paywall_screen.dart';
import 'package:booqs_mobile/consts/validation.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerAccessGuard {
  static int? currentPendingScopeUserId(WidgetRef ref) {
    return currentPendingScopeUserIdFromContainer(
      ProviderScope.containerOf(ref.context, listen: false),
    );
  }

  static int? currentPendingScopeUserIdFromContainer(
    ProviderContainer container,
  ) {
    return container.read(currentUserProvider)?.id;
  }

  static int guardedTodaysAnswersCount({
    required int todaysAnswersCount,
    required int pendingUnsolvedAnswersCount,
  }) {
    return todaysAnswersCount + pendingUnsolvedAnswersCount;
  }

  static bool freeAnswerLimitReached({
    required int todaysAnswersCount,
    required bool premiumEnabled,
  }) {
    return todaysAnswersCount >= answersCountLimitForFreeUsers &&
        premiumEnabled == false;
  }

  static bool shouldBlockUnsolvedAnswer(WidgetRef ref) {
    final int todaysAnswersCount = ref.read(todaysAnswersCountProvider);
    final int pendingUnsolvedAnswersCount =
        ref.read(pendingUnsolvedAnswersCountProvider);
    final bool premiumEnabled = ref.read(premiumEnabledProvider);

    return freeAnswerLimitReached(
      todaysAnswersCount: guardedTodaysAnswersCount(
        todaysAnswersCount: todaysAnswersCount,
        pendingUnsolvedAnswersCount: pendingUnsolvedAnswersCount,
      ),
      premiumEnabled: premiumEnabled,
    );
  }

  static bool interceptIfNeeded(WidgetRef ref, {bool showPaywall = true}) {
    if (!shouldBlockUnsolvedAnswer(ref)) {
      return false;
    }

    if (showPaywall) {
      Dialogs.slideFromBottomFade(const AnswerPaywallScreen());
    }
    return true;
  }

  static bool reserveUnsolvedAnswerIfAllowed(
    WidgetRef ref, {
    bool showPaywall = true,
    int? userId,
  }) {
    if (interceptIfNeeded(ref, showPaywall: showPaywall)) {
      return false;
    }

    final int? effectiveUserId = userId ?? currentPendingScopeUserId(ref);
    if (effectiveUserId == null) {
      return false;
    }

    reserveUnsolvedAnswerFromContainer(
      ProviderScope.containerOf(ref.context, listen: false),
      userId: effectiveUserId,
    );
    return true;
  }

  static void reserveUnsolvedAnswerFromContainer(
    ProviderContainer container, {
    int? userId,
  }) {
    final int? effectiveUserId =
        userId ?? currentPendingScopeUserIdFromContainer(container);
    if (effectiveUserId == null) return;

    final notifier =
        container.read(pendingUnsolvedAnswersCountByUserProvider.notifier);
    final Map<int, int> pendingByUser = Map<int, int>.from(notifier.state);
    pendingByUser[effectiveUserId] = (pendingByUser[effectiveUserId] ?? 0) + 1;
    notifier.state = pendingByUser;
  }

  static void releaseReservedUnsolvedAnswer(WidgetRef ref) {
    releaseReservedUnsolvedAnswerFromContainer(
      ProviderScope.containerOf(ref.context, listen: false),
      userId: currentPendingScopeUserId(ref),
    );
  }

  static void releaseReservedUnsolvedAnswerFromContainer(
    ProviderContainer container, {
    int? userId,
  }) {
    final int? effectiveUserId =
        userId ?? currentPendingScopeUserIdFromContainer(container);
    if (effectiveUserId == null) return;

    final notifier =
        container.read(pendingUnsolvedAnswersCountByUserProvider.notifier);
    final Map<int, int> pendingByUser = Map<int, int>.from(notifier.state);
    final int currentCount = pendingByUser[effectiveUserId] ?? 0;
    if (currentCount <= 1) {
      pendingByUser.remove(effectiveUserId);
    } else {
      pendingByUser[effectiveUserId] = currentCount - 1;
    }
    notifier.state = pendingByUser;
  }

  static void consumeReservedUnsolvedAnswer(
    WidgetRef ref, {
    required bool correct,
  }) {
    consumeReservedUnsolvedAnswerFromContainer(
      ProviderScope.containerOf(ref.context, listen: false),
      userId: currentPendingScopeUserId(ref),
      correct: correct,
    );
  }

  static void consumeReservedUnsolvedAnswerFromContainer(
    ProviderContainer container, {
    int? userId,
    required bool correct,
  }) {
    final int? effectiveUserId =
        userId ?? currentPendingScopeUserIdFromContainer(container);
    releaseReservedUnsolvedAnswerFromContainer(
      container,
      userId: effectiveUserId,
    );
    if (effectiveUserId == null ||
        container.read(currentUserProvider)?.id != effectiveUserId) {
      return;
    }

    container.read(todaysAnswersCountProvider.notifier).state += 1;
    if (correct) {
      container.read(todaysCorrectAnswersCountProvider.notifier).state += 1;
    }
  }
}
