import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class QuizRequestItemEditorComment extends StatelessWidget {
  const QuizRequestItemEditorComment({super.key, required this.quizRequest});
  final QuizRequest quizRequest;

  @override
  Widget build(BuildContext context) {
    final String editorComment = quizRequest.comment ?? '';
    if (editorComment.isEmpty) {
      return Container();
    }
    return DottedBorder(
        color: Colors.black54,
        strokeWidth: 1,
        padding:
            const EdgeInsets.only(top: 10, bottom: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
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
            MarkdownWithDictLink(
              text: editorComment,
              dictionaryId: quizRequest.dictionaryId,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontColor: Colors.black87,
              selectable: true,
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ));
  }
}
