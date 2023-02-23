import 'package:booqs_mobile/components/review/setting/medium_button.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:flutter/material.dart';

class SentenceItemReadingReviewButton extends StatelessWidget {
  const SentenceItemReadingReviewButton({Key? key, required this.sentence})
      : super(key: key);
  final Sentence sentence;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = sentence.quiz;
    if (quiz == null) {
      return Container();
    }
    final Review? review = quiz.review;
    return ReviewSettingMediumButton(
      quizId: quiz.id,
      review: review,
      label: '読めるようになる',
    );
  }
}
