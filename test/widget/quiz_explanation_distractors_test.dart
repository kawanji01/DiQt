import 'package:booqs_mobile/components/quiz/explanation/distractors.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Quiz buildQuiz({required bool phrase, String? syncedAnswerType}) {
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
    correctAnswer: 'answer',
    langNumberOfAnswer: 21,
    answerReadAloud: false,
    distractor1: 'kick the bucket',
    distractor2: '',
    distractor3: '',
    syncedAnswerType: syncedAnswerType,
    shortAnswerEnabled: false,
    questionHidden: false,
    autoDictLinkOfQuestion: false,
    autoDictLinkOfAnswer: true,
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
          body: QuizExplanationDistractors(quiz: quiz),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  group('QuizExplanationDistractors', () {
    testWidgets(
        'wraps whole distractor into one link when source word is phrase',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(phrase: true, syncedAnswerType: 'entry');

      await pumpScreen(tester, quiz);

      expect(find.byType(TextWithDictLink), findsOneWidget);
      final TextWithDictLink widget =
          tester.widget<TextWithDictLink>(find.byType(TextWithDictLink));
      expect(widget.text, '[[kick the bucket]]');

      final List<RichText> richTexts =
          tester.widgetList<RichText>(find.byType(RichText)).toList();
      final RichText richText = richTexts.firstWhere(
        (RichText item) => (item.text.toPlainText() == 'kick the bucket'),
      );
      final TextSpan rootSpan = richText.text as TextSpan;
      final TextSpan linkSpan = rootSpan.children!.first as TextSpan;
      expect(linkSpan.style?.color, Colors.red);
    });

    testWidgets('keeps word-by-word links when source word is not phrase',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(phrase: false, syncedAnswerType: 'entry');

      await pumpScreen(tester, quiz);

      expect(find.byType(TextWithDictLink), findsOneWidget);
      final TextWithDictLink widget =
          tester.widget<TextWithDictLink>(find.byType(TextWithDictLink));
      expect(widget.text, 'kick the bucket');
    });

    testWidgets(
        'keeps word-by-word links when syncedAnswerType is not entry based',
        (WidgetTester tester) async {
      final Quiz quiz = buildQuiz(phrase: true, syncedAnswerType: 'meaning');

      await pumpScreen(tester, quiz);

      expect(find.byType(TextWithDictLink), findsOneWidget);
      final TextWithDictLink widget =
          tester.widget<TextWithDictLink>(find.byType(TextWithDictLink));
      expect(widget.text, 'kick the bucket');
    });
  });
}
