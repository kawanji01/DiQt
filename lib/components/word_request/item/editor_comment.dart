import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';

class WordRequestItemEditorComment extends StatelessWidget {
  const WordRequestItemEditorComment({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    final String editorComment = wordRequest.comment ?? '';
    if (editorComment.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SharedItemLabel(text: t.wordRequests.editor_comment),
          const SizedBox(
            height: 8,
          ),
          Text(
            editorComment,
            style: const TextStyle(
                fontSize: 16, color: Colors.black87, height: 1.5),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      );
    }
    return Container();
  }
}
