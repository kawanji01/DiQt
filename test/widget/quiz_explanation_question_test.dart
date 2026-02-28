import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/components/quiz/explanation/question.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Quiz buildQuiz({
  required bool autoDictLinkOfQuestion,
  required bool phrase,
  String? syncedQuestionType,
}) {
  final Word word = Word(
    id: 1,
    dictionaryId: 1,
    entry: 'kick the bucket',
    langNumberOfEntry: 21,
    meaning: 'to die',
    langNumberOfMeaning: 44,
    phrase: phrase,
    wordRequestsCount: 0,
    acceptedWordRequestsCount: 0,
    pendingWordRequestsCount: 0,
  );

  return Quiz(
    id: 1,
    drillId: 1,
    appliedDictionaryId: 1,
    question: 'kick the bucket',
    langNumberOfQuestion: 21,
    questionReadAloud: false,
    correctAnswer: 'answer',
    langNumberOfAnswer: 44,
    answerReadAloud: false,
    distractor1: '',
    distractor2: '',
    distractor3: '',
    syncedQuestionType: syncedQuestionType,
    shortAnswerEnabled: false,
    questionHidden: false,
    autoDictLinkOfQuestion: autoDictLinkOfQuestion,
    autoDictLinkOfAnswer: false,
    acceptedQuizRequestsCount: 0,
    pendingQuizRequestsCount: 0,
    quizRequestsCount: 0,
    word: word,
  );
}

Future<void> pumpScreen(WidgetTester tester, Quiz quiz) async {
  LocaleSettings.setLocaleSync(AppLocale.en);
  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        home: Scaffold(
          body: QuizExplanationQuestion(quiz: quiz),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  group('QuizExplanationQuestion', () {
    testWidgets(
        'wraps whole question into one link for phrase entry/entry_audio quizzes',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(
        autoDictLinkOfQuestion: true,
        phrase: true,
        syncedQuestionType: 'entry',
      );

      await pumpScreen(tester, quiz);

      expect(find.byType(TextWithDictLink), findsOneWidget);
      final TextWithDictLink widget =
          tester.widget<TextWithDictLink>(find.byType(TextWithDictLink));
      expect(widget.text, '[[kick the bucket]]');
    });

    testWidgets('does not wrap whole question when source word is not phrase',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(
        autoDictLinkOfQuestion: true,
        phrase: false,
        syncedQuestionType: 'entry',
      );

      await pumpScreen(tester, quiz);

      expect(find.byType(TextWithDictLink), findsOneWidget);
      final TextWithDictLink widget =
          tester.widget<TextWithDictLink>(find.byType(TextWithDictLink));
      expect(widget.text, 'kick the bucket');
    });

    testWidgets(
        'does not wrap whole question when syncedQuestionType is not entry',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(
        autoDictLinkOfQuestion: true,
        phrase: true,
        syncedQuestionType: 'meaning',
      );

      await pumpScreen(tester, quiz);

      expect(find.byType(TextWithDictLink), findsOneWidget);
      final TextWithDictLink widget =
          tester.widget<TextWithDictLink>(find.byType(TextWithDictLink));
      expect(widget.text, 'kick the bucket');
    });

    testWidgets('uses markdown rendering when auto dict link is disabled',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(
        autoDictLinkOfQuestion: false,
        phrase: true,
        syncedQuestionType: 'entry',
      );

      await pumpScreen(tester, quiz);

      expect(find.byType(MarkdownWithDictLink), findsOneWidget);
      expect(find.byType(TextWithDictLink), findsNothing);
    });
  });
}
