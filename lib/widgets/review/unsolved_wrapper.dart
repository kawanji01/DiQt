import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/widgets/quiz/answer.dart';
import 'package:booqs_mobile/widgets/quiz/multiple_choices.dart';
import 'package:booqs_mobile/widgets/quiz/question.dart';
import 'package:booqs_mobile/widgets/quiz/unsolved_content.dart';
import 'package:booqs_mobile/widgets/quiz/unsolved_footer.dart';
import 'package:booqs_mobile/widgets/review/header.dart';
import 'package:flutter/material.dart';

class ReviewUnsolvedWrapper extends StatelessWidget {
  const ReviewUnsolvedWrapper({Key? key, required this.review})
      : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = review.quiz;
    final Drill? drill = review.quiz!.drill;
    final header = ReviewHeader(review: review);
    final question = QuizQuestion(quiz: quiz!, drill: drill!, covering: false);
    final answer = QuizAnswer(quiz: quiz);
    final footer = QuizUnsolvedFooter(review: review);

    // 解答時に問題をフェイドアウトする際にリビルドされてレイアウトが崩れるのを防ぐために、外部からwidgetを渡す
    // ref: https://qiita.com/chooyan_eng/items/ec11f6dcf714f7a2fa3d
    return QuizUnsolvedContent(
        header: header, question: question, answer: answer, footer: footer);
  }
}
