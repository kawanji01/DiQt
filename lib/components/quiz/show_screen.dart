import 'package:booqs_mobile/components/drill/list_quiz.dart';
import 'package:booqs_mobile/components/quiz/edit_button.dart';
import 'package:booqs_mobile/components/quiz/explanation/answer_analysis.dart';
import 'package:booqs_mobile/components/quiz/quiz_requests_button.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:flutter/material.dart';

class QuizShowScreen extends StatelessWidget {
  const QuizShowScreen({super.key, required this.quiz});
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrillListQuiz(
          quiz: quiz,
          isShow: true,
        ),
        QuizEditButton(quiz: quiz, isShow: true),
        QuizQuizRequestsButton(quiz: quiz),
        const SizedBox(height: 48),
        QuizExplanationAnswerAnalysis(quiz: quiz),
        const SizedBox(height: 40),
      ],
    );
  }
}
