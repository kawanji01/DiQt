import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/quiz/multiple_choices.dart';
import 'package:flutter/material.dart';

class QuizAnswer extends StatelessWidget {
  const QuizAnswer({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    Widget _answerForm() {
      if (quiz.distractors != '') {
        return QuizMultipleChoices(quiz: quiz);
      } else {
        return Container();
      }
    }

    return _answerForm();
  }
}
