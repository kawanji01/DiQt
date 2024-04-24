import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/review/setting/large_button.dart';
import 'package:flutter/material.dart';

class WordItemReviewButton extends StatelessWidget {
  const WordItemReviewButton({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = word.quiz;
    if (quiz == null) return Container();
    final Review? review = quiz.review;
    return ReviewSettingLargeButton(
        quizId: quiz.id, review: review, label: t.reviews.word_label);
  }
}
