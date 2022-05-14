import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/answer_analysis/quiz_header.dart';
import 'package:booqs_mobile/widgets/quiz/content.dart';
import 'package:flutter/material.dart';

class AnswerAnalysisListQuiz extends StatelessWidget {
  const AnswerAnalysisListQuiz(
      {Key? key, required this.answerAnalysis, required this.isShow})
      : super(key: key);
  final AnswerAnalysis answerAnalysis;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = answerAnalysis.quiz;
    if (quiz == null) return const Text('Quiz does not exist.');

    final header = AnswerAnalysisQuizHeader(answerAnalysis: answerAnalysis);
    return QuizContent(quiz: quiz, header: header, isShow: isShow);
  }
}
