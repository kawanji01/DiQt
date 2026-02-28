import 'dart:async';

import 'package:booqs_mobile/components/quiz/explanation/ai_explanation.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Quiz buildQuiz() {
  return Quiz(
    id: 1,
    drillId: 1,
    appliedDictionaryId: 1,
    question: 'question',
    langNumberOfQuestion: 1,
    questionReadAloud: false,
    correctAnswer: 'answer',
    langNumberOfAnswer: 0,
    answerReadAloud: false,
    shortAnswerEnabled: false,
    questionHidden: false,
    autoDictLinkOfQuestion: false,
    autoDictLinkOfAnswer: false,
    acceptedQuizRequestsCount: 0,
    pendingQuizRequestsCount: 0,
    quizRequestsCount: 0,
    explanation: '',
  );
}

Future<void> pumpScreen(
  WidgetTester tester, {
  required Quiz quiz,
  Future<Map> Function(int quizId)? requestAIExplanation,
}) async {
  LocaleSettings.setLocaleSync(AppLocale.en);
  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        home: Scaffold(
          body: QuizExplanationAIExplanation(
            quiz: quiz,
            requestAIExplanation: requestAIExplanation,
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  group('QuizExplanationAIExplanation', () {
    testWidgets('shows AI explanation button initially',
        (WidgetTester tester) async {
      await pumpScreen(tester, quiz: buildQuiz());

      expect(find.text('Show AI Explanation'), findsOneWidget);
      expect(find.text('Generating AI explanation...'), findsNothing);
    });

    testWidgets('shows loading then cached AI explanation on success',
        (WidgetTester tester) async {
      final completer = Completer<Map>();
      int requestCount = 0;

      await pumpScreen(
        tester,
        quiz: buildQuiz(),
        requestAIExplanation: (_) {
          requestCount += 1;
          return completer.future;
        },
      );

      await tester.tap(find.byKey(const Key('quizAiExplanationButton')));
      await tester.pump();
      expect(requestCount, 1);
      expect(find.text('Show AI Explanation'), findsNothing);
      expect(find.text('Generating AI explanation...'), findsOneWidget);

      completer.complete({
        'status': 200,
        'ai_explanation': 'Generated explanation',
        'cached': true,
      });
      await tester.pump();

      expect(find.text('Cached explanation'), findsOneWidget);
      expect(find.text('Generated explanation'), findsOneWidget);
    });

    testWidgets('shows inline error and does not allow retry',
        (WidgetTester tester) async {
      int requestCount = 0;

      await pumpScreen(
        tester,
        quiz: buildQuiz(),
        requestAIExplanation: (_) async {
          requestCount += 1;
          return {
            'status': 422,
            'message': 'AI explanation failed',
          };
        },
      );

      await tester.tap(find.byKey(const Key('quizAiExplanationButton')));
      await tester.pump();

      expect(requestCount, 1);
      expect(find.text('Show AI Explanation'), findsNothing);
      expect(find.text('AI explanation failed'), findsOneWidget);
      expect(find.byKey(const Key('quizAiExplanationButton')), findsNothing);
    });
  });
}
