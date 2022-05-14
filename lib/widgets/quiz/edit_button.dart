import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/pages/quiz/edit.dart';
import 'package:booqs_mobile/widgets/quiz/detail_button.dart';
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
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            primary: Colors.black54,
            textStyle: const TextStyle(fontSize: 16),
          ),
          onPressed: () {
            QuizEditPage.push(context, quiz.id);
          },
          child: const Text(
            'この問題を改善する',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }

    if (isShow) return _editButton();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_editButton(), QuizDetailButton(quiz: quiz)],
    );
  }
}
