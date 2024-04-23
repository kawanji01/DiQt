import 'package:booqs_mobile/components/quiz_request/quiz/list_view.dart';
import 'package:booqs_mobile/components/quiz_request/quiz/tabs.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:flutter/material.dart';

class QuizRequestQuizScreen extends StatelessWidget {
  const QuizRequestQuizScreen(
      {super.key, required this.quiz, required this.type});
  final Quiz quiz;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuizRequestQuizTabs(selected: type, quiz: quiz),
        QuizRequestQuizListView(quizId: quiz.id, selected: type)
      ],
    );
  }
}
