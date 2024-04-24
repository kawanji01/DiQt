import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:booqs_mobile/pages/quiz_request/show.dart';
import 'package:flutter/material.dart';

class QuizRequestItemDetailsButton extends StatelessWidget {
  const QuizRequestItemDetailsButton(
      {super.key, required this.quizRequest, this.isShow = false});
  final QuizRequest quizRequest;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    if (isShow) {
      return Container();
    }
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          QuizRequestShowPage.push(context, quizRequest.id);
        },
        child: Text(
          t.shared.details,
          style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
