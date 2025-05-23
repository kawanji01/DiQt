import 'package:booqs_mobile/components/weakness/invalid_item_error.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/weakness.dart';
import 'package:booqs_mobile/components/quiz/item.dart';
import 'package:booqs_mobile/components/weakness/quiz_header.dart';
import 'package:flutter/material.dart';

class WeaknessListQuiz extends StatelessWidget {
  const WeaknessListQuiz({super.key, required this.weakness});
  final Weakness weakness;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = weakness.quiz;
    if (quiz == null) {
      return const WeaknessInvalidItemError();
    }

    final header = WeaknessQuizHeader(weakness: weakness);
    return QuizItem(
      quiz: quiz,
      header: header,
      isShow: false,
    );
  }
}
