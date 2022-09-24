import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/review.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/widgets/quiz/answer_part.dart';
import 'package:booqs_mobile/widgets/quiz/explanation/screen.dart';
import 'package:booqs_mobile/widgets/quiz/footer.dart';
import 'package:booqs_mobile/widgets/quiz/question_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizContent extends ConsumerWidget {
  const QuizContent(
      {Key? key,
      required this.quiz,
      required this.header,
      required this.isShow})
      : super(key: key);
  final Quiz quiz;
  final Widget header;
  final bool isShow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Drill? drill = quiz.drill;
    if (drill == null) return const Text('Drill does not exist.');
    final Review? review = quiz.review;
    final question = QuizQuestionPart(quiz: quiz, drill: drill);
    final answer = QuizAnswerPart(
      quiz: quiz,
      unsolved: false,
    );
    final footer = QuizFooter(
      quiz: quiz,
      review: review,
      isShow: isShow,
    );

    return NotificationListener<AnswerNotification>(
      onNotification: (notification) {
        // 解説を表示する
        // 解説モーダル内の辞書リンクで遷移後のページでも解答インタラクションが表示されてしまうので、
        // bottomSheetを表示するときにインタラクションも消しておく
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          // 丸める
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)),
          ),
          // showModalBottomSheetで表示される中身
          builder: (context) => QuizExplanationScreen(
            answerNotification: notification,
          ),
        );
        return true;
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 1,
            ),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 24),
            header,
            question,
            const SizedBox(height: 16),
            answer,
            const SizedBox(height: 8),
            footer,
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
