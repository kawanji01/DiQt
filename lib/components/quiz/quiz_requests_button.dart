import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/utils/booqs_on_web.dart';
import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:flutter/material.dart';

class QuizQuizRequestsButton extends StatelessWidget {
  const QuizQuizRequestsButton({Key? key, required this.quiz})
      : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    Widget acceptedWordRequestsButton() {
      final String redirectPath = 'quizzes/${quiz.id}/accepted_quiz_requests';
      return InkWell(
          onTap: () {
            BooQsOnWeb.open(context, redirectPath);
          },
          child: SmallOutlineGrayButton(
            icon: Icons.history,
            label: '問題の改善履歴（${quiz.acceptedQuizRequestsCount}）',
          ));
    }

    Widget pendingWordRequestsButton() {
      if (quiz.pendingQuizRequestsCount == 0) return Container();

      final String redirectPath = 'quizzes/${quiz.id}/pending_quiz_requests';
      return TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          textStyle: const TextStyle(fontSize: 16),
        ),
        onPressed: () {
          BooQsOnWeb.open(context, redirectPath);
        },
        child: Text(
          '${quiz.pendingQuizRequestsCount}件の審査中の編集',
          style: const TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [acceptedWordRequestsButton(), pendingWordRequestsButton()],
    );
  }
}
