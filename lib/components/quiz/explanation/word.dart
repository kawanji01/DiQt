import 'package:booqs_mobile/components/sentence/list_item.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/word/list_item.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class QuizExplanationWord extends StatelessWidget {
  const QuizExplanationWord({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    final Word? word = quiz.word ?? quiz.referenceWord;
    final Sentence? sentence = quiz.sentence ?? quiz.reversedSentence;

    if (word != null) {
      return Column(children: [
        const SharedItemLabel(text: '問題の元となった語彙'),
        WordListItem(
          word: word,
        ),
      ]);
    }

    if (sentence != null) {
      return Column(
        children: [
          const SharedItemLabel(text: '問題の元となった例文'),
          SentenceListItem(
            sentence: sentence,
            isShow: false,
          ),
        ],
      );
    }
    return Container();
  }
}
