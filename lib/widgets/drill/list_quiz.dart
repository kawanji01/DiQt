import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/drill/quiz_header.dart';
import 'package:booqs_mobile/widgets/quiz/content.dart';
import 'package:flutter/material.dart';

class DrillListQuiz extends StatelessWidget {
  const DrillListQuiz({Key? key, required this.quiz, required this.isShow})
      : super(key: key);
  final Quiz quiz;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    final header = DrillQuizHeader(quiz: quiz);
    return QuizContent(quiz: quiz, header: header, isShow: isShow);
  }
}
