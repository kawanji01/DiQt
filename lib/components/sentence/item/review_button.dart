import 'package:booqs_mobile/components/review/setting/medium_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:flutter/material.dart';

class SentenceItemReviewButton extends StatelessWidget {
  const SentenceItemReviewButton({Key? key, required this.sentence})
      : super(key: key);
  final Sentence sentence;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = sentence.quiz;
    if (quiz == null) {
      return Container();
    }
    final Review? review = quiz.review;
    String label = t.sentences.review_label;
    if (sentence.langNumberOfOriginal == sentence.langNumberOfTranslation) {
      label = t.sentences.review_label_listening;
    }
    return ReviewSettingMediumButton(
      quizId: quiz.id,
      review: review,
      label: label,
    );
  }
}
