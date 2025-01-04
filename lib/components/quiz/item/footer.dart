import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/components/quiz/item/detail_button.dart';
import 'package:booqs_mobile/components/review/setting/small_buttton.dart';
import 'package:flutter/material.dart';

class QuizItemFooter extends StatelessWidget {
  const QuizItemFooter(
      {super.key,
      required this.quiz,
      required this.review,
      required this.isShow});
  final Quiz quiz;
  final Review? review;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    Widget detailedButton() {
      if (isShow) return Container();
      return QuizItemDetailButton(quiz: quiz);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ReviewSettingSmallButton(quiz: quiz, review: review),
        detailedButton(),
      ],
    );
  }
}
