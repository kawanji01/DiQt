import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/components/quiz/explanation/answer.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Quiz buildQuiz({
  required bool autoDictLinkOfAnswer,
  required bool phrase,
  String? syncedAnswerType,
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
    question: 'question',
    langNumberOfQuestion: 44,
    questionReadAloud: false,
    correctAnswer: 'kick the bucket',
    langNumberOfAnswer: 21,
    answerReadAloud: false,
    distractor1: '',
    distractor2: '',
    distractor3: '',
    syncedAnswerType: syncedAnswerType,
    shortAnswerEnabled: false,
    questionHidden: false,
    autoDictLinkOfQuestion: false,
    autoDictLinkOfAnswer: autoDictLinkOfAnswer,
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
          body: QuizExplanationAnswer(quiz: quiz),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  group('QuizExplanationAnswer', () {
    testWidgets(
        'wraps whole answer into one link for phrase entry/entry_audio quizzes',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(
        autoDictLinkOfAnswer: true,
        phrase: true,
        syncedAnswerType: 'entry',
      );

      await pumpScreen(tester, quiz);

      expect(find.byType(TextWithDictLink), findsOneWidget);
      final TextWithDictLink widget =
          tester.widget<TextWithDictLink>(find.byType(TextWithDictLink));
      expect(widget.text, '[[kick the bucket]]');
    });

    testWidgets('does not wrap whole answer when source word is not phrase',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(
        autoDictLinkOfAnswer: true,
        phrase: false,
        syncedAnswerType: 'entry',
      );

      await pumpScreen(tester, quiz);

      expect(find.byType(TextWithDictLink), findsOneWidget);
      final TextWithDictLink widget =
          tester.widget<TextWithDictLink>(find.byType(TextWithDictLink));
      expect(widget.text, 'kick the bucket');
    });

    testWidgets('does not wrap whole answer when syncedAnswerType is not entry',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(
        autoDictLinkOfAnswer: true,
        phrase: true,
        syncedAnswerType: 'meaning',
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
        autoDictLinkOfAnswer: false,
        phrase: true,
        syncedAnswerType: 'entry',
      );

      await pumpScreen(tester, quiz);

      expect(find.byType(MarkdownWithDictLink), findsOneWidget);
      expect(find.byType(TextWithDictLink), findsNothing);
    });
  });
}
