import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/components/drill/quiz_header.dart';
import 'package:booqs_mobile/components/quiz/item.dart';
import 'package:flutter/material.dart';

class DrillListQuiz extends StatelessWidget {
  const DrillListQuiz({super.key, required this.quiz, required this.isShow});
  final Quiz quiz;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    final header = DrillQuizHeader(quiz: quiz);
    return QuizItem(quiz: quiz, header: header, isShow: isShow);
  }
}
