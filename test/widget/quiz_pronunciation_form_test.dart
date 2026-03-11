import 'dart:async';

import 'package:booqs_mobile/components/quiz/item/answer_part.dart';
import 'package:booqs_mobile/components/quiz/item/pronunciation_form.dart';
import 'package:booqs_mobile/consts/validation.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/data/provider/drill_lap.dart';
import 'package:booqs_mobile/data/provider/solved_quiz_ids.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class FakePronunciationRecorder implements QuizPronunciationRecorder {
  String? lastPath;

  @override
  Future<bool> hasPermission() async => true;

  @override
  Future<void> start({required String path}) async => lastPath = path;

  @override
  Future<String?> stop() async => lastPath;

  @override
  void dispose() {}
}

class DelayedPronunciationRecorder implements QuizPronunciationRecorder {
  DelayedPronunciationRecorder(this.startCompleter);

  final Completer<void> startCompleter;
  String? lastPath;

  @override
  Future<bool> hasPermission() async => true;

  @override
  Future<void> start({required String path}) async {
    lastPath = path;
    await startCompleter.future;
  }

  @override
  Future<String?> stop() async => lastPath;

  @override
  void dispose() {}
}

class FakePronunciationReadyCue {
  int playCount = 0;

  Future<void> call() async {
    playCount += 1;
  }
}

Future<void> noopReadyCue() async {}

Quiz buildQuiz({
  int id = 1,
  required int langNumberOfAnswer,
}) {
  return Quiz(
    id: id,
    drillId: 1,
    appliedDictionaryId: 1,
    question: 'question',
    langNumberOfQuestion: 44,
    questionReadAloud: false,
    correctAnswer: 'spoken answer',
    langNumberOfAnswer: langNumberOfAnswer,
    answerReadAloud: false,
    shortAnswerEnabled: true,
    answerMode: 'speech',
    questionHidden: false,
    autoDictLinkOfQuestion: false,
    autoDictLinkOfAnswer: false,
    acceptedQuizRequestsCount: 0,
    pendingQuizRequestsCount: 0,
    quizRequestsCount: 0,
  );
}

User buildUser() {
  return buildUserWith(
    premium: true,
    todaysAnswersCount: 0,
    todaysCorrectAnswersCount: 0,
  );
}

Map<String, dynamic> buildDrillJson({
  int id = 1,
  String title = 'Current Drill',
}) {
  return {
    'id': id,
    'applied_dictionary_id': 1,
    'user_id': 1,
    'chapter_id': null,
    'dictionary_id': 1,
    'sentence_dictionary_id': null,
    'title': title,
    'lang_number_of_title': 21,
    'introduction': 'intro',
    'reference_url': '',
    'thumbnail_url': '',
    'public_uid': 'drill-$id',
    'strict_solving_mode': false,
    'exam_mode': false,
    'archived_at': null,
    'answer_histories_count': 0,
    'quizzes_count': 10,
    'created_at': '2026-03-10T10:00:00Z',
    'updated_at': '2026-03-10T10:00:00Z',
    'drill_lap': null,
    'chapter': null,
    'dictionary': null,
  };
}

Map<String, dynamic> buildDrillLapJson({
  int id = 1,
  int drillId = 1,
  int userId = 1,
  int clearsCount = 2,
}) {
  return {
    'id': id,
    'user_id': userId,
    'drill_id': drillId,
    'clears_count': clearsCount,
    'cleared': false,
    'last_answered_at': '2026-03-10T10:00:00Z',
    'cleared_at': null,
    'created_at': '2026-03-10T10:00:00Z',
    'updated_at': '2026-03-10T10:00:00Z',
  };
}

Map<String, dynamic> buildUserJson({
  int userId = 1,
  required bool premium,
  required int todaysAnswersCount,
  required int todaysCorrectAnswersCount,
  String? authToken,
  Map<String, dynamic>? drillInProgressJson,
}) {
  return {
    'id': userId,
    'public_uid': 'user-$userId',
    'name': 'User',
    'email': 'user@example.com',
    'lang_number': 44,
    'learning_lang_number': 21,
    'time_zone_name': 'Tokyo',
    'mail_delivered': true,
    'amount_of_exp': 0,
    'answer_histories_count': 0,
    'todays_answer_histories_count': todaysAnswersCount,
    'todays_correct_answer_histories_count': todaysCorrectAnswersCount,
    'whole_week_answer_histories_count': 0,
    'whole_month_answer_histories_count': 0,
    'answer_days_count': 0,
    'continuous_answer_days_count': 0,
    'continuous_goal_achievement_count': 0,
    'continuous_review_completion_count': 0,
    'achievement_maps_count': 0,
    'notes_count': 0,
    'premium': premium,
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
    'token_for_native_app': authToken,
    'drill_in_progress': drillInProgressJson,
  };
}

User buildUserWith({
  int userId = 1,
  required bool premium,
  required int todaysAnswersCount,
  required int todaysCorrectAnswersCount,
  String? authToken,
  Map<String, dynamic>? drillInProgressJson,
}) {
  return User.fromJson(
    buildUserJson(
      userId: userId,
      premium: premium,
      todaysAnswersCount: todaysAnswersCount,
      todaysCorrectAnswersCount: todaysCorrectAnswersCount,
      authToken: authToken,
      drillInProgressJson: drillInProgressJson,
    ),
  );
}

Map<String, dynamic> successfulPronunciationResponse({
  User? user,
  Map<String, dynamic>? userJson,
  bool correct = true,
  int quizId = 1,
  int? solvedQuizzesCount,
  Map<String, dynamic>? drillLapJson,
}) {
  return {
    'status': 200,
    'answer_creator': {
      'answer_history': {
        'id': 1,
        'user_id': 1,
        'quiz_id': quizId,
        'drill_id': 1,
        'answer_analysis_id': 1,
        'correct': correct,
        'at_drill_page': true,
        'at_review_page': false,
        'at_weakness_page': false,
        'interval_step_up': false,
        'answer_date': '2026-03-10',
        'first_of_the_day': false,
        'answer': 'spoken answer',
        'goal_achievement': false,
        'review_completion': false,
        'continuation': false,
        'continuation_all_week': false,
        'continuation_all_month': false,
        'continuation_all_year': false,
        'time_zone_name': 'Tokyo',
        'created_at': '2026-03-10T10:00:00Z',
        'updated_at': '2026-03-10T10:00:00Z',
      },
      'base_point': 0,
      'answer_point': 0,
      'start_point': 0,
      'lap_clear_point': 0,
      'answer_days_point': 0,
      'continuous_answer_days_point': 0,
      'continuation_all_week_point': 0,
      'continuation_all_month_point': 0,
      'continuation_all_year_point': 0,
      'review_completion_point': 0,
      'continuous_review_completion_point': 0,
      'goal_achievement_point': 0,
      'continuous_goal_achievement_point': 0,
      'all_point': 0,
      'solved_quizzes_count': solvedQuizzesCount,
      'drill_lap': drillLapJson,
    },
    'user': userJson ?? (user ?? buildUser()).toJson(),
  };
}

Future<ProviderContainer> pumpWidgetWithProviders(
  WidgetTester tester, {
  required Widget child,
  User? user,
}) async {
  LocaleSettings.setLocaleSync(AppLocale.en);
  final ProviderContainer container = ProviderContainer(
    overrides: [
      currentUserProvider.overrideWith((ref) {
        final state = CurrentUserState();
        state.update(user);
        return state;
      }),
    ],
  );
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
  TestWidgetsFlutterBinding.ensureInitialized();

  group('QuizItemPronunciationForm', () {
    setUp(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        SystemChannels.platform,
        (MethodCall methodCall) async => null,
      );
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, null);
    });

    testWidgets('falls back to text input for unsupported locales',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(langNumberOfAnswer: 25);

      await pumpWidgetWithProviders(
        tester,
        child: QuizItemAnswerPart(
          quiz: quiz,
          unsolved: true,
          answerType: 'drill',
        ),
      );

      expect(find.text(t.quizzes.pronunciation_unavailable), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets(
        'uses local text input for speech quizzes outside unsolved flow',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(langNumberOfAnswer: 21);

      await pumpWidgetWithProviders(
        tester,
        child: QuizItemAnswerPart(
          quiz: quiz,
          unsolved: false,
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text(t.quizzes.pronunciation_hold_to_speak), findsNothing);
    });

    testWidgets('falls back to text input when pronunciation assessment fails',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(langNumberOfAnswer: 21);

      await pumpWidgetWithProviders(
        tester,
        user: buildUser(),
        child: QuizItemPronunciationForm(
          quiz: quiz,
          unsolved: true,
          answerType: 'drill',
          recorder: FakePronunciationRecorder(),
          playReadyCue: noopReadyCue,
          submitAnswer: (_, __) async => {
            'status': 422,
            'message': 'assessment failed',
          },
          showError: (_, __) {},
          showPaywallOnAnswerLimit: false,
        ),
      );

      final GestureDetector detector =
          tester.widget(find.byType(GestureDetector).first);
      detector.onLongPressStart!(
        const LongPressStartDetails(globalPosition: Offset.zero),
      );
      await tester.pump();
      detector.onLongPressEnd!(
        const LongPressEndDetails(globalPosition: Offset.zero),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.byType(TextField), findsOneWidget);
      expect(
          find.text(t.quizzes.pronunciation_runtime_fallback), findsOneWidget);
    });

    testWidgets('keeps the pronunciation form active on auth failures',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(langNumberOfAnswer: 21);

      await pumpWidgetWithProviders(
        tester,
        user: buildUser(),
        child: QuizItemPronunciationForm(
          quiz: quiz,
          unsolved: true,
          answerType: 'drill',
          recorder: FakePronunciationRecorder(),
          playReadyCue: noopReadyCue,
          submitAnswer: (_, __) async => {
            'status': 401,
            'message': 'unauthorized',
          },
          showError: (_, __) {},
          showPaywallOnAnswerLimit: false,
        ),
      );

      final GestureDetector detector =
          tester.widget(find.byType(GestureDetector).first);
      detector.onLongPressStart!(
        const LongPressStartDetails(globalPosition: Offset.zero),
      );
      await tester.pump();
      detector.onLongPressEnd!(
        const LongPressEndDetails(globalPosition: Offset.zero),
      );
      await tester.pump();

      expect(find.byType(TextField), findsNothing);
      expect(find.text(t.quizzes.pronunciation_runtime_fallback), findsNothing);
      expect(find.text(t.quizzes.pronunciation_hold_to_speak), findsOneWidget);
    });

    testWidgets('does not allow a second submission after success',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(langNumberOfAnswer: 21);
      int submitCount = 0;

      await pumpWidgetWithProviders(
        tester,
        user: buildUser(),
        child: QuizItemPronunciationForm(
          quiz: quiz,
          unsolved: true,
          answerType: 'drill',
          recorder: FakePronunciationRecorder(),
          playReadyCue: noopReadyCue,
          submitAnswer: (_, __) async {
            submitCount += 1;
            return successfulPronunciationResponse();
          },
          dispatchNotification: (_, __) {},
          showPaywallOnAnswerLimit: false,
        ),
      );

      final GestureDetector detector =
          tester.widget(find.byType(GestureDetector).first);
      detector.onLongPressStart!(
        const LongPressStartDetails(globalPosition: Offset.zero),
      );
      await tester.pump();
      detector.onLongPressEnd!(
        const LongPressEndDetails(globalPosition: Offset.zero),
      );
      await tester.pump();

      detector.onLongPressStart!(
        const LongPressStartDetails(globalPosition: Offset.zero),
      );
      await tester.pump();
      detector.onLongPressEnd!(
        const LongPressEndDetails(globalPosition: Offset.zero),
      );
      await tester.pump();

      expect(submitCount, 1);
    });

    testWidgets(
        'does not duplicate solved quiz bookkeeping before notification',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(langNumberOfAnswer: 21);
      late ProviderContainer container;

      container = await pumpWidgetWithProviders(
        tester,
        user: buildUser(),
        child: QuizItemPronunciationForm(
          quiz: quiz,
          unsolved: true,
          answerType: 'drill',
          recorder: FakePronunciationRecorder(),
          playReadyCue: noopReadyCue,
          submitAnswer: (_, __) async =>
              successfulPronunciationResponse(quizId: quiz.id),
          dispatchNotification: (_, notification) {
            final List<int> solvedQuizIds =
                List<int>.from(container.read(solvedQuizIdsProvider));
            container.read(solvedQuizIdsProvider.notifier).state = [
              ...solvedQuizIds,
              notification.quiz.id,
            ];
          },
          showPaywallOnAnswerLimit: false,
        ),
      );

      final GestureDetector detector =
          tester.widget(find.byType(GestureDetector).first);
      detector.onLongPressStart!(
        const LongPressStartDetails(globalPosition: Offset.zero),
      );
      await tester.pump();
      detector.onLongPressEnd!(
        const LongPressEndDetails(globalPosition: Offset.zero),
      );
      await tester.pump();
      await tester.pump();

      expect(container.read(solvedQuizIdsProvider), [quiz.id]);
    });

    testWidgets('syncs successful submissions after unmount',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(langNumberOfAnswer: 21);
      final Completer<Map> submission = Completer<Map>();
      bool notificationDispatched = false;
      final User initialUser = buildUserWith(
        premium: false,
        todaysAnswersCount: answersCountLimitForFreeUsers - 1,
        todaysCorrectAnswersCount: 0,
        authToken: 'initial-token',
        drillInProgressJson: buildDrillJson(id: 3, title: 'Old Drill'),
      );
      final Map<String, dynamic> responseUserJson = buildUserJson(
        premium: true,
        todaysAnswersCount: answersCountLimitForFreeUsers,
        todaysCorrectAnswersCount: 1,
        drillInProgressJson: buildDrillJson(id: 9, title: 'Updated Drill'),
      );
      const int solvedQuizzesCount = 7;
      final Map<String, dynamic> drillLapJson = buildDrillLapJson(
        id: 5,
        drillId: 1,
        userId: initialUser.id,
        clearsCount: 3,
      );

      final ProviderContainer container = await pumpWidgetWithProviders(
        tester,
        user: initialUser,
        child: QuizItemPronunciationForm(
          quiz: quiz,
          unsolved: true,
          answerType: 'drill',
          recorder: FakePronunciationRecorder(),
          playReadyCue: noopReadyCue,
          submitAnswer: (_, __) => submission.future,
          dispatchNotification: (_, __) {
            notificationDispatched = true;
          },
          showPaywallOnAnswerLimit: false,
        ),
      );

      final GestureDetector detector =
          tester.widget(find.byType(GestureDetector).first);
      detector.onLongPressStart!(
        const LongPressStartDetails(globalPosition: Offset.zero),
      );
      await tester.pump();
      detector.onLongPressEnd!(
        const LongPressEndDetails(globalPosition: Offset.zero),
      );
      await tester.pump();

      expect(container.read(pendingUnsolvedAnswersCountProvider), 1);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: TranslationProvider(
            child: const MaterialApp(
              home: Scaffold(body: SizedBox.shrink()),
            ),
          ),
        ),
      );
      await tester.pump();

      submission.complete(
        successfulPronunciationResponse(
          userJson: responseUserJson,
          quizId: quiz.id,
          solvedQuizzesCount: solvedQuizzesCount,
          drillLapJson: drillLapJson,
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(notificationDispatched, isFalse);
      expect(container.read(todaysAnswersCountProvider),
          answersCountLimitForFreeUsers);
      expect(container.read(todaysCorrectAnswersCountProvider), 1);
      expect(container.read(pendingUnsolvedAnswersCountProvider), 0);
      expect(container.read(solvedQuizIdsProvider), contains(quiz.id));
      expect(container.read(currentUserProvider)?.premium, isTrue);
      expect(container.read(currentUserProvider)?.authToken, 'initial-token');
      expect(container.read(currentUserProvider)?.drillInProgress?.id, 9);
      expect(
          container.read(drillSolvedQuizzesCountProvider), solvedQuizzesCount);
      expect(container.read(drillLapProvider)?.id, 5);
    });

    testWidgets('plays the ready cue once when recording becomes active',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(langNumberOfAnswer: 21);
      final FakePronunciationReadyCue readyCue = FakePronunciationReadyCue();

      await pumpWidgetWithProviders(
        tester,
        user: buildUser(),
        child: QuizItemPronunciationForm(
          quiz: quiz,
          unsolved: true,
          answerType: 'drill',
          recorder: FakePronunciationRecorder(),
          playReadyCue: readyCue.call,
          submitAnswer: (_, __) async => successfulPronunciationResponse(),
          dispatchNotification: (_, __) {},
          showPaywallOnAnswerLimit: false,
        ),
      );

      final GestureDetector detector =
          tester.widget(find.byType(GestureDetector).first);
      detector.onLongPressStart!(
        const LongPressStartDetails(globalPosition: Offset.zero),
      );
      await tester.pump();

      expect(readyCue.playCount, 1);
      expect(find.text(t.quizzes.pronunciation_speak_now), findsOneWidget);
    });

    testWidgets(
        'skips the ready cue when the press is released before startup finishes',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(langNumberOfAnswer: 21);
      final Completer<void> recorderStart = Completer<void>();
      final FakePronunciationReadyCue readyCue = FakePronunciationReadyCue();
      int submitCount = 0;

      await pumpWidgetWithProviders(
        tester,
        user: buildUser(),
        child: QuizItemPronunciationForm(
          quiz: quiz,
          unsolved: true,
          answerType: 'drill',
          recorder: DelayedPronunciationRecorder(recorderStart),
          playReadyCue: readyCue.call,
          submitAnswer: (_, __) async {
            submitCount += 1;
            return successfulPronunciationResponse();
          },
          dispatchNotification: (_, __) {},
          showPaywallOnAnswerLimit: false,
        ),
      );

      final GestureDetector detector =
          tester.widget(find.byType(GestureDetector).first);
      detector.onLongPressStart!(
        const LongPressStartDetails(globalPosition: Offset.zero),
      );
      await tester.pump();
      detector.onLongPressEnd!(
        const LongPressEndDetails(globalPosition: Offset.zero),
      );
      await tester.pump();

      recorderStart.complete();
      await tester.pump();
      await tester.pump();

      expect(readyCue.playCount, 0);
      expect(submitCount, 1);
    });

    testWidgets('shows inline loading while waiting for pronunciation feedback',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(langNumberOfAnswer: 21);
      final Completer<Map> submission = Completer<Map>();

      await pumpWidgetWithProviders(
        tester,
        user: buildUser(),
        child: QuizItemPronunciationForm(
          quiz: quiz,
          unsolved: true,
          answerType: 'drill',
          recorder: FakePronunciationRecorder(),
          playReadyCue: noopReadyCue,
          submitAnswer: (_, __) => submission.future,
          dispatchNotification: (_, __) {},
          showPaywallOnAnswerLimit: false,
        ),
      );

      final GestureDetector detector =
          tester.widget(find.byType(GestureDetector).first);
      detector.onLongPressStart!(
        const LongPressStartDetails(globalPosition: Offset.zero),
      );
      await tester.pump();
      detector.onLongPressEnd!(
        const LongPressEndDetails(globalPosition: Offset.zero),
      );
      await tester.pump();

      expect(find.text(t.quizzes.pronunciation_submitting), findsNWidgets(2));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      submission.complete(successfulPronunciationResponse());
      await tester.pump();
      await tester.pump();

      expect(find.text(t.quizzes.pronunciation_submitting), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets(
        'reserves the last free answer slot while a request is in flight',
        (WidgetTester tester) async {
      final Quiz firstQuiz = buildQuiz(id: 1, langNumberOfAnswer: 21);
      final Quiz secondQuiz = buildQuiz(id: 2, langNumberOfAnswer: 21);
      final Completer<Map> firstSubmission = Completer<Map>();
      int secondSubmitCount = 0;

      final ProviderContainer container = await pumpWidgetWithProviders(
        tester,
        user: buildUserWith(
          premium: false,
          todaysAnswersCount: answersCountLimitForFreeUsers - 1,
          todaysCorrectAnswersCount: 0,
        ),
        child: Column(
          children: [
            QuizItemPronunciationForm(
              quiz: firstQuiz,
              unsolved: true,
              answerType: 'drill',
              recorder: FakePronunciationRecorder(),
              playReadyCue: noopReadyCue,
              submitAnswer: (_, __) => firstSubmission.future,
              dispatchNotification: (_, __) {},
              showPaywallOnAnswerLimit: false,
            ),
            QuizItemPronunciationForm(
              quiz: secondQuiz,
              unsolved: true,
              answerType: 'drill',
              recorder: FakePronunciationRecorder(),
              playReadyCue: noopReadyCue,
              submitAnswer: (_, __) async {
                secondSubmitCount += 1;
                return successfulPronunciationResponse();
              },
              dispatchNotification: (_, __) {},
              showPaywallOnAnswerLimit: false,
            ),
            Consumer(
              builder: (_, ref, __) => Text(
                'answers:${ref.watch(todaysAnswersCountProvider)} '
                'pending:${ref.watch(pendingUnsolvedAnswersCountProvider)}',
              ),
            ),
          ],
        ),
      );

      final GestureDetector firstDetector =
          tester.widget(find.byType(GestureDetector).at(0));
      firstDetector.onLongPressStart!(
        const LongPressStartDetails(globalPosition: Offset.zero),
      );
      await tester.pump();
      firstDetector.onLongPressEnd!(
        const LongPressEndDetails(globalPosition: Offset.zero),
      );
      await tester.pump();

      expect(
        find.text(
          'answers:${answersCountLimitForFreeUsers - 1} pending:1',
        ),
        findsOneWidget,
      );

      final GestureDetector secondDetector =
          tester.widget(find.byType(GestureDetector).at(1));
      secondDetector.onLongPressStart!(
        const LongPressStartDetails(globalPosition: Offset.zero),
      );
      await tester.pump();
      secondDetector.onLongPressEnd!(
        const LongPressEndDetails(globalPosition: Offset.zero),
      );
      await tester.pump();

      expect(secondSubmitCount, 0);

      firstSubmission.complete(successfulPronunciationResponse());
      await tester.pump();
      await tester.pump();

      expect(
        container.read(todaysAnswersCountProvider),
        answersCountLimitForFreeUsers,
      );
      expect(
        container.read(pendingUnsolvedAnswersCountProvider),
        0,
      );
    });

    testWidgets(
        'keeps pending pronunciation submissions scoped to the submitting user',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(id: 1, langNumberOfAnswer: 21);
      final Completer<Map> submission = Completer<Map>();
      bool notificationDispatched = false;

      final ProviderContainer container = await pumpWidgetWithProviders(
        tester,
        user: buildUserWith(
          userId: 1,
          premium: false,
          todaysAnswersCount: answersCountLimitForFreeUsers - 1,
          todaysCorrectAnswersCount: 0,
          authToken: 'token-1',
        ),
        child: QuizItemPronunciationForm(
          quiz: quiz,
          unsolved: true,
          answerType: 'drill',
          recorder: FakePronunciationRecorder(),
          playReadyCue: noopReadyCue,
          submitAnswer: (_, __) => submission.future,
          dispatchNotification: (_, __) {
            notificationDispatched = true;
          },
          showPaywallOnAnswerLimit: false,
        ),
      );

      final GestureDetector detector =
          tester.widget(find.byType(GestureDetector));
      detector.onLongPressStart!(
        const LongPressStartDetails(globalPosition: Offset.zero),
      );
      await tester.pump();
      detector.onLongPressEnd!(
        const LongPressEndDetails(globalPosition: Offset.zero),
      );
      await tester.pump();

      expect(container.read(pendingUnsolvedAnswersCountProvider), 1);

      container.read(currentUserProvider.notifier).update(
            buildUserWith(
              userId: 2,
              premium: false,
              todaysAnswersCount: 0,
              todaysCorrectAnswersCount: 0,
              authToken: 'token-2',
            ),
          );
      container.read(todaysAnswersCountProvider.notifier).state = 0;
      container.read(todaysCorrectAnswersCountProvider.notifier).state = 0;
      await tester.pump();

      expect(container.read(pendingUnsolvedAnswersCountProvider), 0);

      submission.complete(
        successfulPronunciationResponse(
          user: buildUserWith(
            userId: 1,
            premium: false,
            todaysAnswersCount: answersCountLimitForFreeUsers,
            todaysCorrectAnswersCount: 1,
            authToken: 'token-1',
          ),
          quizId: quiz.id,
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(notificationDispatched, isFalse);
      expect(container.read(currentUserProvider)?.id, 2);
      expect(container.read(currentUserProvider)?.authToken, 'token-2');
      expect(container.read(todaysAnswersCountProvider), 0);
      expect(container.read(todaysCorrectAnswersCountProvider), 0);
      expect(container.read(pendingUnsolvedAnswersCountProvider), 0);
      expect(container.read(solvedQuizIdsProvider), isNot(contains(quiz.id)));
      expect(find.text(t.quizzes.pronunciation_hold_to_speak), findsOneWidget);
    });
  });
}
