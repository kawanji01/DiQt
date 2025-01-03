import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/drill/list_quiz.dart';
import 'package:booqs_mobile/components/word/detailed_item.dart';
import 'package:flutter/material.dart';

class WordShowScreen extends StatelessWidget {
  const WordShowScreen({super.key, required this.word});
  final Word word;

  @override
  Widget build(BuildContext context) {
    Widget reversedQuiz() {
      final Quiz? quiz = word.reversedQuiz;
      if (quiz == null) return Container();
      return DrillListQuiz(
        quiz: quiz,
        isShow: false,
      );
    }

    Widget quiz() {
      final Quiz? quiz = word.quiz;
      if (quiz == null) return Container();
      return DrillListQuiz(
        quiz: quiz,
        isShow: false,
      );
    }

    Widget sentenceQuiz() {
      final Sentence? sentence = word.sentence;
      if (sentence == null) return Container();
      final Quiz? sentenceQuiz = sentence.quiz;
      if (sentenceQuiz == null) return Container();
      return DrillListQuiz(
        quiz: sentenceQuiz,
        isShow: false,
      );
    }

    Widget reversedSentenceQuiz() {
      final Sentence? sentence = word.sentence;
      if (sentence == null) return Container();
      final Quiz? sentenceQuiz = sentence.reversedQuiz;
      if (sentenceQuiz == null) return Container();
      return DrillListQuiz(
        quiz: sentenceQuiz,
        isShow: false,
      );
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      WordDetailedItem(word: word),
      quiz(),
      reversedQuiz(),
      sentenceQuiz(),
      reversedSentenceQuiz(),
      const SizedBox(
        height: 120,
      ),
    ]);
  }
}
