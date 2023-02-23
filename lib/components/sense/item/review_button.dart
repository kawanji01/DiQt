import 'package:booqs_mobile/components/review/setting/medium_button.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/sense.dart';
import 'package:flutter/material.dart';

class SenseItemReviewButton extends StatelessWidget {
  const SenseItemReviewButton({Key? key, required this.sense})
      : super(key: key);
  final Sense sense;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = sense.quiz;
    if (quiz == null) {
      return Container();
    }
    final Review? review = quiz.review;
    return ReviewSettingMediumButton(
      quizId: quiz.id,
      review: review,
      label: '覚える',
    );
  }
}
