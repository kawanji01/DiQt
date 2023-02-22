import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/drill/list_quiz.dart';
import 'package:booqs_mobile/components/word/detailed_item.dart';
import 'package:flutter/material.dart';

class WordShowScreen extends StatelessWidget {
  const WordShowScreen({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = word.quiz;
    final Sentence? sentence = word.sentence;

    // 問題がなければ早期リターン
    if (quiz == null) {
      return WordDetailedItem(word: word);
    }

    Widget sentenceQuiz() {
      if (sentence == null) return Container();
      final Quiz? sentenceQuiz = sentence.quiz;
      if (sentenceQuiz == null) return Container();
      return DrillListQuiz(
        quiz: sentenceQuiz,
        isShow: false,
      );
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      WordDetailedItem(word: word),
      DrillListQuiz(
        quiz: quiz,
        isShow: false,
      ),
      sentenceQuiz(),
      const SizedBox(
        height: 120,
      ),
    ]);
  }
}
