import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/widgets/quiz/answer.dart';
import 'package:booqs_mobile/widgets/quiz/question.dart';
import 'package:booqs_mobile/widgets/quiz/unsolved_footer.dart';
import 'package:flutter/material.dart';

class QuizUnsolvedContent extends StatelessWidget {
  const QuizUnsolvedContent(
      {Key? key, required this.quiz, required this.drill, required this.review})
      : super(key: key);
  final Quiz quiz;
  final Drill drill;
  final Review? review;

  @override
  Widget build(BuildContext context) {
    // qustion, answer, footerの三つを並べる
    // answer_settingによる変化は、このWidgetで管理する。
    return Column(
      children: [
        QuizQuestion(quiz: quiz, drill: drill, covering: false),
        const SizedBox(height: 16),
        QuizAnswer(
          quiz: quiz,
        ),
        const SizedBox(height: 8),
        QuizUnsolvedFooter(review: review),
      ],
    );
    //return QuizQuestion(quiz: quiz, drill: drill, covering: false);
  }
}
