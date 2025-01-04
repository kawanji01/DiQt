import 'package:booqs_mobile/components/sentence/list_item.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/word/list_item.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class QuizExplanationWord extends StatelessWidget {
  const QuizExplanationWord({super.key, required this.quiz});
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    final Word? word = quiz.word;
    final Sentence? sentence = quiz.sentence;

    if (word != null) {
      return Column(children: [
        SharedItemLabel(text: t.quizzes.source_word),
        WordListItem(
          word: word,
        ),
      ]);
    }

    if (sentence != null) {
      return Column(
        children: [
          SharedItemLabel(text: t.quizzes.source_sentence),
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
