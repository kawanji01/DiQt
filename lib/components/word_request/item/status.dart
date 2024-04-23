import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';

class WordRequestItemStatus extends StatelessWidget {
  const WordRequestItemStatus({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    String type;
    String status;
    Color color;
    if (wordRequest.addition) {
      type = t.wordRequests.addition;
    } else if (wordRequest.modification) {
      type = t.wordRequests.modification;
    } else if (wordRequest.elimination) {
      type = t.wordRequests.elimination;
    } else {
      type = '';
    }

    if (wordRequest.acceptance) {
      status = t.wordRequests.acceptance;
      color = Colors.green;
    } else if (wordRequest.rejection) {
      status = t.wordRequests.rejection;
      color = Colors.red;
    } else if (wordRequest.notClosed()) {
      status = t.wordRequests.pending;
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
