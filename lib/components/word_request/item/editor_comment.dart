import 'package:booqs_mobile/models/word_request.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';

class WordRequestItemEditorComment extends StatelessWidget {
  const WordRequestItemEditorComment({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    final String editorComment = wordRequest.comment ?? '';
    if (editorComment.isNotEmpty) {
      return DottedBorder(
          color: Colors.black54,
          strokeWidth: 1,
          padding:
              const EdgeInsets.only(top: 10, bottom: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.comment,
                    size: 14,
                    color: Colors.black54,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    t.wordRequests.editor_comment,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                editorComment,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ));
    }
    return Container();
  }
}
