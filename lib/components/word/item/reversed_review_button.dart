import 'package:booqs_mobile/components/review/setting/large_button.dart';
import 'package:booqs_mobile/consts/sources.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';

class WordItemReversedReviewButton extends StatelessWidget {
  const WordItemReversedReviewButton({super.key, required this.word});
  final Word word;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = word.reversedQuiz;
    if (quiz == null) return Container();
    final Review? review = quiz.review;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        ReviewSettingLargeButton(
            quizId: quiz.id,
            review: review,
            label: t.reviews.reversed_word_label),

        // const SizedBox(width: 16),
        TextButton.icon(
          onPressed: () {
            WebPageLauncher.openByWebView(introductionOfWordReviewUrl);
          },
          icon: const Icon(
            Icons.help_outline,
            size: 16,
            color: Colors.green,
          ),
          label: Text(t.words.what_is_this_button,
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
