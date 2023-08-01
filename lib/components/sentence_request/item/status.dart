import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:flutter/material.dart';

class SentenceRequestItemStatus extends StatelessWidget {
  const SentenceRequestItemStatus({super.key, required this.sentenceRequest});
  final SentenceRequest sentenceRequest;

  @override
  Widget build(BuildContext context) {
    String type;
    String status;
    Color color;
    if (sentenceRequest.addition) {
      type = t.sentenceRequests.addition;
    } else if (sentenceRequest.modification) {
      type = t.sentenceRequests.modification;
    } else if (sentenceRequest.elimination) {
      type = t.sentenceRequests.elimination;
    } else {
      type = '';
    }

    if (sentenceRequest.acceptance) {
      status = t.sentenceRequests.acceptance;
      color = Colors.green;
    } else if (sentenceRequest.rejection) {
      status = t.sentenceRequests.rejection;
      color = Colors.red;
    } else if (sentenceRequest.notClosed()) {
      status = t.sentenceRequests.pending;
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
