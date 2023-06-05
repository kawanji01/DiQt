import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';

class WordRequestEntry extends StatelessWidget {
  const WordRequestEntry({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    String editType = '';
    if (wordRequest.addition) {
      editType = '${wordRequest.entry} / ${t.wordRequests.addition}';
    }
    if (wordRequest.modification) {
      editType =
          '${wordRequest.previousEntry} / ${t.wordRequests.modification}';
    }
    if (wordRequest.elimination) {
      editType = '${wordRequest.previousEntry} / ${t.wordRequests.elimination}';
    }

    String status = '';
    if (wordRequest.isPending()) {
      status = '(${t.wordRequests.pending})';
    } else if (wordRequest.rejection) {
      status = '(${t.wordRequests.rejected})';
    }

    return Text(
      '$editType $status',
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }
}
