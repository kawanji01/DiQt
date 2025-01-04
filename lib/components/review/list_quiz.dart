import 'package:booqs_mobile/components/review/invalid_item_error.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/components/quiz/item.dart';
import 'package:booqs_mobile/components/review/quiz_header.dart';
import 'package:flutter/material.dart';

class ReviewListQuiz extends StatelessWidget {
  const ReviewListQuiz({super.key, required this.review});
  final Review review;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = review.quiz;
    if (quiz == null) {
      return const ReviewInvalidItemError();
    }

    final header = ReviewQuizHeader(review: review);
    return QuizItem(
      quiz: quiz,
      header: header,
      isShow: false,
    );
  }
}
