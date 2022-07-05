import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/dictionary/name.dart';
import 'package:booqs_mobile/widgets/drill/list_quiz.dart';
import 'package:booqs_mobile/widgets/review/large_setting_button.dart';
import 'package:booqs_mobile/widgets/word/edit_button.dart';
import 'package:booqs_mobile/widgets/word/entry.dart';
import 'package:booqs_mobile/widgets/word/explanation.dart';
import 'package:booqs_mobile/widgets/word/meaning.dart';
import 'package:booqs_mobile/widgets/word/sentence.dart';
import 'package:booqs_mobile/widgets/word/tag_buttons.dart';
import 'package:booqs_mobile/widgets/word/word_requests_button.dart';
import 'package:flutter/material.dart';

class WordShowScreen extends StatelessWidget {
  const WordShowScreen({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    final Dictionary? dictionary = word.dictionary;
    final Quiz? quiz = word.quiz;

    final Sentence? sentence = word.sentence;

    Widget _reviewButton() {
      if (quiz == null) return const Text('Quiz does not exist.');
      final Review? review = quiz.review;
      return ReviewLargeSettingButton(quizId: quiz.id, review: review);
    }

    Widget _word() {
      if (dictionary == null) return const Text('Dictionary does not exist.');

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DictionaryName(dictionary: dictionary),
          //WordTagButtons(tags: word.tags),
          const SizedBox(height: 10),
          WordEntry(word: word),
          const SizedBox(
            height: 10,
          ),
          WordMeaning(word: word),
          const SizedBox(
            height: 24,
          ),
          //WordReviewButton(word: word),
          _reviewButton(),
          WordExplanation(word: word),
          WordSentence(word: word),
          WordEditButton(
            word: word,
            isShow: true,
          ),
          const SizedBox(
            height: 16,
          ),
          WordWordRequestsButton(word: word),
          const SizedBox(
            height: 24,
          ),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      );
    }

    // 問題がなければ早期リターン
    if (quiz == null) return _word();

    Widget _sentenceQuiz() {
      if (sentence == null) return Container();
      final Quiz? sentenceQuiz = sentence.quiz;
      if (sentenceQuiz == null) return Container();
      return DrillListQuiz(
        quiz: sentenceQuiz,
        isShow: false,
      );
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      _word(),
      DrillListQuiz(
        quiz: quiz,
        isShow: false,
      ),
      _sentenceQuiz(),
      const SizedBox(
        height: 120,
      ),
    ]);
  }
}
