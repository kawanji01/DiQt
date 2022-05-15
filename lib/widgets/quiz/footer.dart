import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/widgets/quiz/detail_button.dart';
import 'package:booqs_mobile/widgets/review/small_setting_buttton.dart';
import 'package:flutter/material.dart';

class QuizFooter extends StatelessWidget {
  const QuizFooter(
      {Key? key,
      required this.quiz,
      required this.review,
      required this.isShow})
      : super(key: key);
  final Quiz quiz;
  final Review? review;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    Widget _detailedButton() {
      if (isShow) return Container();
      return QuizDetailButton(quiz: quiz);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ReviewSmallSettingButton(quiz: quiz, review: review),
        _detailedButton(),
      ],
    );
  }
}
