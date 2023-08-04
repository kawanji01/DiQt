import 'package:booqs_mobile/components/review/setting/large_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class WordItemReversedReviewButton extends StatelessWidget {
  const WordItemReversedReviewButton({super.key, required this.word});
  final Word word;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = word.reversedQuiz;
    if (quiz == null) return Container();
    final Review? review = quiz.review;
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: ReviewSettingLargeButton(
          quizId: quiz.id,
          review: review,
          label: t.reviews.reversed_word_label),
    );
  }
}
