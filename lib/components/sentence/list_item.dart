import 'package:booqs_mobile/components/sentence/review_button.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/components/review/large_setting_button.dart';
import 'package:booqs_mobile/components/sentence/edit_button.dart';
import 'package:booqs_mobile/components/sentence/item.dart';
import 'package:flutter/material.dart';

class SentenceListItem extends StatelessWidget {
  const SentenceListItem(
      {Key? key, required this.sentence, required this.isShow})
      : super(key: key);
  final Sentence sentence;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    // 復習ボタン
    Widget reviewButton() {
      final Quiz? quiz = sentence.quiz;
      if (quiz == null) return Container();
      final Review? review = quiz.review;
      return SentenceReviewButton(
        quizId: quiz.id,
        review: review,
        speaking: false,
      );
    }

    //
    Widget speakingReviewButton() {
      final Quiz? quiz = sentence.speakingQuiz;
      if (quiz == null) return Container();
      final Review? review = quiz.review;
      return SentenceReviewButton(
          quizId: quiz.id, review: review, speaking: true);
    }

    return Column(
      children: [
        SentenceItem(sentence: sentence),
        const SizedBox(
          height: 32,
        ),
        reviewButton(),
        const SizedBox(
          height: 16,
        ),
        speakingReviewButton(),
        SentenceEditButton(sentence: sentence, isShow: isShow)
      ],
    );
  }
}
