import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/utils/booqs_on_web.dart';
import 'package:flutter/material.dart';

class QuizDetailButton extends StatelessWidget {
  const QuizDetailButton({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    final String redirectPath = '/quizzes/${quiz.id}';
    return Container(
      // 左寄せ
      alignment: Alignment.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          primary: Colors.black54,
          textStyle: const TextStyle(fontSize: 16),
        ),
        onPressed: () {
          BooQsOnWeb.open(context, redirectPath);
        },
        child: const Text(
          '詳細',
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
