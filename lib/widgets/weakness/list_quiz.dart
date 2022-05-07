import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/weakness.dart';
import 'package:booqs_mobile/widgets/quiz/content.dart';
import 'package:booqs_mobile/widgets/weakness/quiz_header.dart';
import 'package:flutter/material.dart';

class WeaknessListQuiz extends StatelessWidget {
  const WeaknessListQuiz({Key? key, required this.weakness}) : super(key: key);
  final Weakness weakness;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = weakness.quiz;
    if (quiz == null) return const Text('Quiz does not exist.');

    final header = WeaknessQuizHeader(weakness: weakness);
    return QuizContent(quiz: quiz, header: header);
  }
}
