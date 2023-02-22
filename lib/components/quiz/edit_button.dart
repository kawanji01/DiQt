import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/quiz/edit.dart';
import 'package:booqs_mobile/components/quiz/detail_button.dart';
import 'package:booqs_mobile/components/sentence/edit_button.dart';
import 'package:booqs_mobile/components/word/edit_button.dart';
import 'package:flutter/material.dart';

class QuizEditButton extends StatelessWidget {
  const QuizEditButton({Key? key, required this.quiz, required this.isShow})
      : super(key: key);
  final Quiz quiz;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    Widget editButton() {
      return Container(
        // 左寄せ
        alignment: Alignment.topLeft,
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black54,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            textStyle: const TextStyle(fontSize: 16),
          ),
          onPressed: () {
            QuizEditPage.push(context, quiz.id);
          },
          child: const Text(
            '問題を編集する',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }

    Widget detailButton() {
      if (isShow) return Container();
      return QuizDetailButton(quiz: quiz);
    }

    Widget sourceEditButton() {
      final Word? word = quiz.word ?? quiz.referenceWord;
      final Sentence? sentence = quiz.sentence;
      if (word != null) {
        return WordEditButton(word: word, isShow: isShow);
      }
      if (sentence != null) {
        return SentenceEditButton(sentence: sentence, isShow: isShow);
      }
      return Container();
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [editButton(), detailButton()],
      ),
      sourceEditButton()
    ]);
  }
}
