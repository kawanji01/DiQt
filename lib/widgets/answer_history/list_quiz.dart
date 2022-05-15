import 'package:booqs_mobile/models/answer_history.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/answer_history/quiz_header.dart';
import 'package:booqs_mobile/widgets/quiz/content.dart';
import 'package:flutter/material.dart';

class AnswerHistoryListQuiz extends StatelessWidget {
  const AnswerHistoryListQuiz({Key? key, required this.answerHistory})
      : super(key: key);
  final AnswerHistory answerHistory;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = answerHistory.quiz;
    if (quiz == null) return const Text('Quiz does not exist.');

    final header = AnswerHistoryQuizHeader(answerHistory: answerHistory);
    return QuizContent(quiz: quiz, header: header, isShow: false);
  }
}
