import 'package:booqs_mobile/components/weakness/invalid_item_error.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/models/weakness.dart';
import 'package:booqs_mobile/components/quiz/item/answer_part.dart';
import 'package:booqs_mobile/components/quiz/item/question_part.dart';
import 'package:booqs_mobile/components/quiz/unsolved_item.dart';
import 'package:booqs_mobile/components/quiz/item/unsolved_footer.dart';
import 'package:booqs_mobile/components/weakness/quiz_header.dart';
import 'package:flutter/material.dart';

class WeaknessUnsolvedQuizWrapper extends StatelessWidget {
  const WeaknessUnsolvedQuizWrapper({super.key, required this.weakness});
  final Weakness weakness;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = weakness.quiz;

    if (quiz == null) {
      return const WeaknessInvalidItemError();
    }

    final Drill? drill = quiz.drill;
    if (drill == null) {
      return const WeaknessInvalidItemError();
    }

    final Review? review = quiz.review;

    final header = WeaknessQuizHeader(
      weakness: weakness,
    );
    final question = QuizItemQuestionPart(quiz: quiz, drill: drill);
    final answer = QuizItemAnswerPart(
      quiz: quiz,
      unsolved: true,
    );
    final footer = QuizItemUnsolvedFooter(quiz: quiz, review: review);

    // 解答時に問題をフェイドアウトする際にリビルドされてレイアウトが崩れるのを防ぐために、外部からwidgetを渡す
    // ref: https://qiita.com/chooyan_eng/items/ec11f6dcf714f7a2fa3d
    return QuizUnsolvedItem(
        quiz: quiz,
        header: header,
        question: question,
        answer: answer,
        footer: footer);
  }
}
