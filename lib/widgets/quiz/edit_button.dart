import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/quiz/edit.dart';
import 'package:booqs_mobile/widgets/quiz/detail_button.dart';
import 'package:booqs_mobile/widgets/sentence/edit_button.dart';
import 'package:booqs_mobile/widgets/word/edit_button.dart';
import 'package:flutter/material.dart';

class QuizEditButton extends StatelessWidget {
  const QuizEditButton({Key? key, required this.quiz, required this.isShow})
      : super(key: key);
  final Quiz quiz;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    Widget _editButton() {
      return Container(
        // 左寄せ
        alignment: Alignment.topLeft,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            primary: Colors.black54,
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

    Widget _detailButton() {
      if (isShow) return Container();
      return QuizDetailButton(quiz: quiz);
    }

    Widget _sourceEditButton() {
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
        children: [_editButton(), _detailButton()],
      ),
      _sourceEditButton()
    ]);
  }
}
