import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/widgets/quiz/detail_button.dart';
import 'package:booqs_mobile/widgets/review/small_setting_buttton.dart';
import 'package:flutter/material.dart';

class QuizFooter extends StatelessWidget {
  const QuizFooter({Key? key, required this.quiz, required this.review})
      : super(key: key);
  final Quiz quiz;
  final Review? review;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ReviewSmallSettingButton(quiz: quiz, review: review),
        QuizDetailButton(quiz: quiz),
      ],
    );
  }
}
