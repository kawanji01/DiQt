import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/components/quiz/item/skip_button.dart';
import 'package:booqs_mobile/components/review/setting/small_buttton.dart';
import 'package:flutter/material.dart';

class QuizItemUnsolvedFooter extends StatelessWidget {
  const QuizItemUnsolvedFooter({super.key, required this.quiz, this.review});
  final Quiz quiz;
  final Review? review;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ReviewSettingSmallButton(quiz: quiz, review: review),
        QuizItemSkipButton(quiz: quiz),
      ],
    );
  }
}
