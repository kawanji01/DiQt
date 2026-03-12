import 'package:booqs_mobile/components/quiz/explanation/answer_analysis.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Quiz buildQuizWithAnalysis({
  String answerMode = 'speech',
  List<Map<String, dynamic>> pronunciationIncorrectReasons = const [
    {
      'key': 'accuracy_low',
      'params': {'score': 70, 'threshold': 80}
    }
  ],
}) {
  final AnswerAnalysis answerAnalysis = AnswerAnalysis(
    id: 1,
    userId: 1,
    quizId: 1,
    drillId: 1,
    answerHistoriesCount: 3,
    incorrectAnswerHistoriesCount: 2,
    lastAnswer: 'spoken answer',
    correctAnswerRate: 33.3,
    lastAnsweredAt: DateTime.utc(2026, 3, 10, 10),
    lastAnswerCorrect: false,
    solvedAtDrill: true,
    createdAt: DateTime.utc(2026, 3, 10, 10),
    updatedAt: DateTime.utc(2026, 3, 10, 10),
    pronunciationIncorrectReasons: pronunciationIncorrectReasons,
    pronunciationReferenceHighlightSegments: [
      {'text': 'spo', 'issue': false},
      {'text': 'ken', 'issue': true}
    ],
    pronunciationWordAssessmentRows: [
      {
        'word': 'spoken',
        'score': 70,
        'issue': true,
        'error_type': 'Mispronunciation'
      }
    ],
    pronunciationConnectedSpeechFeedbacks: [
      {
        'category': 'linking',
        'message_key': 'linking_general',
        'boundary_label': 'turn it',
        'evidence': {'left_word': 'turn', 'right_word': 'it'}
      }
    ],
    pronunciationPhonemeComparisonRows: [
      {
        'word': 'spoken',
        'word_segments': [
          {'text': 'spo', 'issue': false},
          {'text': 'ken', 'issue': true}
        ],
        'expected_phoneme': 'oʊ',
        'actual_phoneme': 'ɔ',
        'score': 68,
        'mismatch': true
      }
    ],
    lastPronunciationPayload: const {'recognized_text': 'spoken answer'},
  );

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
    answerMode: answerMode,
    questionHidden: false,
    autoDictLinkOfQuestion: false,
    autoDictLinkOfAnswer: false,
    acceptedQuizRequestsCount: 0,
    pendingQuizRequestsCount: 0,
    quizRequestsCount: 0,
    answerAnalysis: answerAnalysis,
  );
}

void main() {
  testWidgets('renders pronunciation analysis sections for speech quizzes',
      (WidgetTester tester) async {
    LocaleSettings.setLocaleSync(AppLocale.en);
    final Quiz quiz = buildQuizWithAnalysis();

    await tester.pumpWidget(
      ProviderScope(
        child: TranslationProvider(
          child: MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: QuizExplanationAnswerAnalysis(quiz: quiz),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(
      find.ancestor(
        of: find.byType(SharedItemLabel),
        matching: find.byType(Center),
      ),
      findsOneWidget,
    );
    expect(find.text(t.answerAnalyses.pronunciation_incorrect_reason),
        findsOneWidget);
    expect(find.text(t.answerAnalyses.pronunciation_word_feedback_title),
        findsOneWidget);
    expect(find.text(t.answerAnalyses.connected_speech_feedback_title),
        findsOneWidget);
    expect(find.text(t.answerAnalyses.pronunciation_phoneme_comparison_title),
        findsOneWidget);
    expect(find.textContaining('70/80'), findsOneWidget);
  });

  testWidgets(
      'renders saved pronunciation analysis sections even when quiz answer mode is text',
      (WidgetTester tester) async {
    LocaleSettings.setLocaleSync(AppLocale.en);
    final Quiz quiz = buildQuizWithAnalysis(answerMode: 'text');

    await tester.pumpWidget(
      ProviderScope(
        child: TranslationProvider(
          child: MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: QuizExplanationAnswerAnalysis(quiz: quiz),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(t.answerAnalyses.pronunciation_incorrect_reason),
        findsOneWidget);
    expect(find.text(t.answerAnalyses.pronunciation_word_feedback_title),
        findsOneWidget);
  });
}
