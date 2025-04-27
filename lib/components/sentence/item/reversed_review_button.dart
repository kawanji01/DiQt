import 'package:booqs_mobile/components/review/setting/medium_button.dart';
import 'package:booqs_mobile/consts/sources.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:flutter/material.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';

class SentenceItemReversedReviewButton extends StatelessWidget {
  const SentenceItemReversedReviewButton({super.key, required this.sentence});
  final Sentence sentence;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = sentence.reversedQuiz;
    if (quiz == null) {
      return Container();
    }
    final Review? review = quiz.review;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReviewSettingMediumButton(
          quizId: quiz.id,
          review: review,
          label: t.sentences.reversed_review_label,
        ),

        // const SizedBox(width: 16),
        TextButton.icon(
          onPressed: () {
            WebPageLauncher.openByWebView(introductionOfSentenceReviewUrl);
          },
          icon: const Icon(
            Icons.help_outline,
            size: 16,
            color: Colors.green,
          ),
          label: Text(t.sentences.what_is_this_button,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.green)),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 0),
          ),
        ),
      ],
    );
  }
}
