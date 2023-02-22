import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/components/quiz/content.dart';
import 'package:booqs_mobile/components/review/quiz_header.dart';
import 'package:flutter/material.dart';

class ReviewListQuiz extends StatelessWidget {
  const ReviewListQuiz({Key? key, required this.review}) : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = review.quiz;
    if (quiz == null) return const Text('Quiz does not exist.');

    final header = ReviewQuizHeader(review: review);
    return QuizContent(
      quiz: quiz,
      header: header,
      isShow: false,
    );
  }
}
