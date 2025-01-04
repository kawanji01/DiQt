import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/components/answer_analysis/quiz_header.dart';
import 'package:booqs_mobile/components/quiz/item.dart';
import 'package:flutter/material.dart';

class AnswerAnalysisListQuiz extends StatelessWidget {
  const AnswerAnalysisListQuiz(
      {super.key, required this.answerAnalysis, required this.isShow});
  final AnswerAnalysis answerAnalysis;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = answerAnalysis.quiz;
    if (quiz == null) return const Text('Quiz does not exist.');

    final header = AnswerAnalysisQuizHeader(answerAnalysis: answerAnalysis);
    return QuizItem(quiz: quiz, header: header, isShow: isShow);
  }
}
