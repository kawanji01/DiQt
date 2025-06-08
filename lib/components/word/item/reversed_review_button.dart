import 'package:booqs_mobile/components/review/setting/large_button.dart';
import 'package:booqs_mobile/components/shared/reversed_review_onboarding.dart';
import 'package:booqs_mobile/consts/images.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        ReviewSettingLargeButton(
            quizId: quiz.id,
            review: review,
            label: t.reviews.reversed_word_label),
        TextButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const ReversedReviewOnboarding(pages: [
                {
                  'title': '意味を覚える',
                  'description':
                      '「意味を覚える」ボタンを押すことで、後日、復習として「単語から意味を答える」問題を出題します。\n単語を読む力や聞く力を鍛えたい方におすすめです。',
                  'image': '$onboardingImagesUrl/word_review_onboarding_1.png',
                },
                {
                  'title': '単語を覚える',
                  'description':
                      '「単語を覚える」ボタンを押すことで、後日、復習として「意味から見出し語を答える」問題を出題します。\n単語を話す力や書く力を鍛えたい方におすすめです。',
                  'image': '$onboardingImagesUrl/word_review_onboarding_2.png',
                },
              ]),
            );
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
