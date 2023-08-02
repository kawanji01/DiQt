import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:flutter/material.dart';

class QuizRequestItemStatus extends StatelessWidget {
  const QuizRequestItemStatus({super.key, required this.quizRequest});
  final QuizRequest quizRequest;

  @override
  Widget build(BuildContext context) {
    String type;
    String status;
    Color color;
    if (quizRequest.addition) {
      type = t.quizRequests.addition;
    } else if (quizRequest.modification) {
      type = t.quizRequests.modification;
    } else if (quizRequest.elimination) {
      type = t.quizRequests.elimination;
    } else {
      type = '';
    }

    if (quizRequest.acceptance) {
      status = t.quizRequests.acceptance;
      color = Colors.green;
    } else if (quizRequest.rejection) {
      status = t.quizRequests.rejection;
      color = Colors.red;
    } else if (quizRequest.notClosed()) {
      status = t.quizRequests.pending;
      color = Colors.black54;
    } else {
      status = '';
      color = Colors.black54;
    }

    return Row(
      children: [
        Text(
          '$type - ',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          status,
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}
