import 'package:booqs_mobile/components/review/setting/medium_button.dart';
import 'package:booqs_mobile/components/shared/reversed_review_onboarding.dart';
import 'package:booqs_mobile/consts/images.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:flutter/material.dart';

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
            showDialog(
              context: context,
              builder: (context) => const ReversedReviewOnboarding(pages: [
                {
                  'title': '読めるようになる',
                  'description':
                      '「読めるようになる」ボタンを押すことで、後日、復習として「例文から翻訳を答える」問題を出題します。\n例文を読む力や聞く力を鍛えたい方におすすめです。',
                  'image':
                      '$onboardingImagesUrl/sentence_review_onboarding_1.png',
                },
                {
                  'title': '話せるようになる',
                  'description':
                      '「話せるようになる」ボタンを押すことで、後日、復習として「翻訳から例文を答える」問題を出題します。\n例文を話す力や書く力を鍛えたい方におすすめです。',
                  'image':
                      '$onboardingImagesUrl/sentence_review_onboarding_2.png',
                },
              ]),
            );
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
