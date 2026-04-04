import 'package:booqs_mobile/components/quiz/answer/interaction.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Quiz buildQuiz({required String answerMode}) {
  return Quiz(
    id: 1,
    drillId: 1,
    appliedDictionaryId: 1,
    question: 'question',
    langNumberOfQuestion: 44,
    questionReadAloud: false,
    correctAnswer: 'correct answer',
    langNumberOfAnswer: 21,
    answerReadAloud: false,
    shortAnswerEnabled: true,
    answerMode: answerMode,
    questionHidden: false,
    autoDictLinkOfQuestion: false,
    autoDictLinkOfAnswer: false,
    acceptedQuizRequestsCount: 0,
    pendingQuizRequestsCount: 0,
    quizRequestsCount: 0,
  );
}

User buildUser() {
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
    'answer_histories_count': 1,
    'todays_answer_histories_count': 1,
    'todays_correct_answer_histories_count': 0,
    'whole_week_answer_histories_count': 0,
    'whole_month_answer_histories_count': 0,
    'answer_days_count': 0,
    'continuous_answer_days_count': 0,
    'continuous_goal_achievement_count': 0,
    'continuous_review_completion_count': 0,
    'achievement_maps_count': 0,
    'notes_count': 0,
    'premium': true,
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
    'answer_setting': {
      'id': 1,
      'user_id': 1,
      'interval_step_up_condition': 1,
      'initial_interval': 1,
      'daily_goal': 30,
      'choices_covered': false,
      'question_covered': false,
      'strict_solving_mode': false,
      'review_notification_timer': 6,
      'review_notification_timer_set': false,
      'review_notification_enabled': true,
      'strict_reviewing_mode': false,
      'se_enabled': true,
      'effect_enabled': false,
      'speech_rate': 50,
      'review_delete_condition': 9,
      'weakness_condition': 2,
      'overcoming_condition': 80,
      'created_at': '2026-03-10T10:00:00Z',
      'updated_at': '2026-03-10T10:00:00Z',
    },
  });
}

Future<void> pumpInteraction(
  WidgetTester tester, {
  required AnswerNotification notification,
}) async {
  final ProviderContainer container = ProviderContainer(
    overrides: [
      currentUserProvider.overrideWith((ref) {
        final state = CurrentUserState();
        state.update(notification.user);
        return state;
      }),
    ],
  );

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: TranslationProvider(
        child: MaterialApp(
          home: Scaffold(
            body: QuizAnswerInteraction(notification: notification),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await LocaleSettings.setLocale(AppLocale.ja);
  });

  group('QuizAnswerInteraction', () {
    testWidgets('shows recognized result copy for pronunciation submissions',
        (WidgetTester tester) async {
      final User user = buildUser();
      final AnswerNotification notification = AnswerNotification(
        'こんばんは。',
        false,
        buildQuiz(answerMode: 'speech'),
        user,
        true,
        responseMap: const {'status': 200},
      );

      await pumpInteraction(tester, notification: notification);

      expect(find.text('認識結果: こんばんは。'), findsOneWidget);
      expect(find.byIcon(Icons.mic), findsOneWidget);
      expect(find.byIcon(Icons.clear), findsNothing);
    });

    testWidgets('keeps raw wrong answer display for non-pronunciation answers',
        (WidgetTester tester) async {
      final User user = buildUser();
      final AnswerNotification notification = AnswerNotification(
        'こんばんは。',
        false,
        buildQuiz(answerMode: 'text'),
        user,
        true,
      );

      await pumpInteraction(tester, notification: notification);

      expect(find.text('認識結果: こんばんは。'), findsNothing);
      expect(find.text('こんばんは。'), findsOneWidget);
      expect(find.byIcon(Icons.clear), findsOneWidget);
    });
  });
}
