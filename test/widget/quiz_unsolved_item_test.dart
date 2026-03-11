import 'package:booqs_mobile/components/quiz/item/multiple_choices.dart';
import 'package:booqs_mobile/components/quiz/item/short_answer_form.dart';
import 'package:booqs_mobile/components/quiz/unsolved_item.dart';
import 'package:booqs_mobile/consts/validation.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/solved_quiz_ids.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Quiz buildQuiz() {
  return Quiz(
    id: 1,
    drillId: 1,
    appliedDictionaryId: 1,
    question: 'question',
    langNumberOfQuestion: 44,
    questionReadAloud: false,
    correctAnswer: 'spoken answer',
    langNumberOfAnswer: 21,
    answerReadAloud: false,
    shortAnswerEnabled: true,
    answerMode: 'text',
    questionHidden: false,
    autoDictLinkOfQuestion: false,
    autoDictLinkOfAnswer: false,
    acceptedQuizRequestsCount: 0,
    pendingQuizRequestsCount: 0,
    quizRequestsCount: 0,
  );
}

User buildFreeUser() {
  return User.fromJson({
    'id': 1,
    'public_uid': 'user-1',
    'name': 'User',
    'email': 'user@example.com',
    'lang_number': 44,
    'learning_lang_number': 21,
    'time_zone_name': 'Tokyo',
    'mail_delivered': true,
    'amount_of_exp': 0,
    'answer_histories_count': 0,
    'todays_answer_histories_count': answersCountLimitForFreeUsers - 1,
    'todays_correct_answer_histories_count': 0,
    'whole_week_answer_histories_count': 0,
    'whole_month_answer_histories_count': 0,
    'answer_days_count': 0,
    'continuous_answer_days_count': 0,
    'continuous_goal_achievement_count': 0,
    'continuous_review_completion_count': 0,
    'achievement_maps_count': 0,
    'notes_count': 0,
    'premium': false,
    'paid_via_native_app': false,
    'unread_notifications_count': 0,
    'unsolved_reviews_count': 0,
    'reviews_count': 0,
    'unsolved_weaknesses_count': 0,
    'weaknesses_count': 0,
    'drills_count': 0,
    'reward_remained': false,
    'todays_translations_count': 0,
    'todays_ai_searches_count': 0,
    'app_favored': false,
    'app_cancel_report_sent': false,
    'lang_initialized': true,
    'review_onboarding_shown': true,
    'activated': true,
  });
}

Future<ProviderContainer> pumpWithProviders(
  WidgetTester tester, {
  required Widget child,
}) async {
  LocaleSettings.setLocaleSync(AppLocale.en);
  final ProviderContainer container = ProviderContainer(
    overrides: [
      currentUserProvider.overrideWith((ref) {
        final state = CurrentUserState();
        state.update(buildFreeUser());
        return state;
      }),
    ],
  );
  container.read(pendingUnsolvedAnswersCountByUserProvider.notifier).state = {
    1: 1,
  };

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: TranslationProvider(
        child: MaterialApp(
          home: Scaffold(body: child),
        ),
      ),
    ),
  );
  await tester.pump();
  return container;
}

void main() {
  testWidgets(
      're-enables unsolved short-answer controls when pending limit blocks notification',
      (WidgetTester tester) async {
    final Quiz quiz = buildQuiz();
    final ProviderContainer container = await pumpWithProviders(
      tester,
      child: QuizUnsolvedItem(
        quiz: quiz,
        header: const SizedBox.shrink(),
        question: const SizedBox.shrink(),
        answer: QuizItemShortAnswerForm(quiz: quiz, unsolved: true),
        footer: const SizedBox.shrink(),
        showPaywallOnAnswerLimit: false,
      ),
    );

    await tester.enterText(find.byType(TextField), quiz.correctAnswer);
    await tester.tap(
      find.descendant(
        of: find.byType(QuizItemShortAnswerForm),
        matching: find.byType(ElevatedButton),
      ),
    );
    await tester.pump();
    await tester.pumpAndSettle();

    final ElevatedButton button = tester.widget(
      find.descendant(
        of: find.byType(QuizItemShortAnswerForm),
        matching: find.byType(ElevatedButton),
      ),
    );
    expect(button.onPressed, isNotNull);
    expect(container.read(solvedQuizIdsProvider), isEmpty);
  });

  testWidgets(
      're-enables unsolved multiple-choice controls when pending limit blocks notification',
      (WidgetTester tester) async {
    final Quiz quiz = buildQuiz();
    final ProviderContainer container = await pumpWithProviders(
      tester,
      child: QuizUnsolvedItem(
        quiz: quiz,
        header: const SizedBox.shrink(),
        question: const SizedBox.shrink(),
        answer: QuizItemMultipleChoices(
          quiz: quiz,
          answerTextList: const ['spoken answer', 'wrong answer'],
          unsolved: true,
        ),
        footer: const SizedBox.shrink(),
        showPaywallOnAnswerLimit: false,
      ),
    );

    await tester.tap(
      find
          .descendant(
            of: find.byType(QuizItemMultipleChoices),
            matching: find.byType(InkWell),
          )
          .first,
    );
    await tester.pump();
    await tester.pumpAndSettle();

    final InkWell choice = tester.widget(
      find
          .descendant(
            of: find.byType(QuizItemMultipleChoices),
            matching: find.byType(InkWell),
          )
          .first,
    );
    expect(choice.onTap, isNotNull);
    expect(container.read(solvedQuizIdsProvider), isEmpty);
  });
}
