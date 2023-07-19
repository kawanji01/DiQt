import 'package:booqs_mobile/components/review/invalid_item_error.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/components/quiz/answer_part.dart';
import 'package:booqs_mobile/components/quiz/question_part.dart';
import 'package:booqs_mobile/components/quiz/unsolved_content.dart';
import 'package:booqs_mobile/components/quiz/unsolved_footer.dart';
import 'package:booqs_mobile/components/review/quiz_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewUnsolvedQuizWrapper extends ConsumerWidget {
  const ReviewUnsolvedQuizWrapper({Key? key, required this.review})
      : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Quiz? quiz = review.quiz;
    if (quiz == null) {
      return const ReviewInvalidItemError();
    }

    final Drill? drill = quiz.drill;
    if (drill == null) {
      return const ReviewInvalidItemError();
    }

    final header = ReviewQuizHeader(review: review);
    final question = QuizQuestionPart(quiz: quiz, drill: drill);
    final answer = QuizAnswerPart(
      quiz: quiz,
      unsolved: true,
    );
    final footer = QuizUnsolvedFooter(quiz: quiz, review: review);

    // 解答時に問題をフェイドアウトする際にリビルドされてレイアウトが崩れるのを防ぐために、外部からwidgetを渡す
    // ref: https://qiita.com/chooyan_eng/items/ec11f6dcf714f7a2fa3d
    return QuizUnsolvedContent(
        quiz: quiz,
        header: header,
        question: question,
        answer: answer,
        footer: footer);
  }
}
