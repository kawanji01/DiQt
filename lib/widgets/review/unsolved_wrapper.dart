import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/utils/answer/answer_request.dart';
import 'package:booqs_mobile/widgets/quiz/answer.dart';
import 'package:booqs_mobile/widgets/quiz/question.dart';
import 'package:booqs_mobile/widgets/quiz/unsolved_content.dart';
import 'package:booqs_mobile/widgets/quiz/unsolved_footer.dart';
import 'package:booqs_mobile/widgets/review/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewUnsolvedWrapper extends ConsumerWidget {
  const ReviewUnsolvedWrapper({Key? key, required this.review})
      : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Quiz? quiz = review.quiz;
    if (quiz == null) {
      return Container(
          padding: const EdgeInsets.all(24),
          child: Text('エラー: quiz-${review.quizId}は存在しません。review-${review.id}'));
    }

    final Drill? drill = quiz.drill;
    if (drill == null) {
      return Container(
          padding: const EdgeInsets.all(24),
          child: Text('エラー: drill-${quiz.drillId}が存在しない。review-${review.id}'));
    }

    final header = ReviewHeader(review: review);
    final question = QuizQuestion(quiz: quiz, drill: drill, covering: false);
    final answer = QuizAnswer(quiz: quiz);
    final footer = QuizUnsolvedFooter(quiz: quiz, review: review);

    return NotificationListener<AnswerNotification>(
      onNotification: (notification) {
        AnswerRequest.call(context, notification, 'review');
        // trueを返すことで通知がこれ以上遡らない
        return true;
      },
      // 解答時に問題をフェイドアウトする際にリビルドされてレイアウトが崩れるのを防ぐために、外部からwidgetを渡す
      // ref: https://qiita.com/chooyan_eng/items/ec11f6dcf714f7a2fa3d
      child: QuizUnsolvedContent(
          quiz: quiz,
          header: header,
          question: question,
          answer: answer,
          footer: footer),
    );
  }
}
