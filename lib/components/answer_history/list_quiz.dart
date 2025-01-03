import 'package:booqs_mobile/models/answer_history.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/components/answer_history/quiz_header.dart';
import 'package:booqs_mobile/components/quiz/item.dart';
import 'package:flutter/material.dart';

class AnswerHistoryListQuiz extends StatelessWidget {
  const AnswerHistoryListQuiz({super.key, required this.answerHistory});
  final AnswerHistory answerHistory;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = answerHistory.quiz;
    if (quiz == null) return const Text('Quiz does not exist.');

    final header = AnswerHistoryQuizHeader(answerHistory: answerHistory);
    return QuizItem(quiz: quiz, header: header, isShow: false);
  }
}
