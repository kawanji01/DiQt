import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/pages/quiz_request/quiz.dart';
import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:flutter/material.dart';

class QuizQuizRequestsButton extends StatelessWidget {
  const QuizQuizRequestsButton({Key? key, required this.quiz})
      : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    Widget pendingWordRequestsButton() {
      if (quiz.pendingQuizRequestsCount == 0) return Container();

      return TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          textStyle: const TextStyle(fontSize: 16),
        ),
        onPressed: () {
          QuizRequestQuizPage.push(context, quiz.id, 'pending');
        },
        child: Text(
          '${t.dictionaries.pending_quiz_requests}(${quiz.pendingQuizRequestsCount})',
          style: const TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
            onTap: () {
              QuizRequestQuizPage.push(context, quiz.id, 'accepted');
            },
            child: SmallOutlineGrayButton(
              icon: Icons.history,
              label:
                  '${t.dictionaries.accepted_quiz_requests}（${quiz.acceptedQuizRequestsCount}）',
            )),
        pendingWordRequestsButton()
      ],
    );
  }
}
