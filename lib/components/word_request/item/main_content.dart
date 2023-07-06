import 'package:booqs_mobile/components/word_request/item/diffs.dart';
import 'package:booqs_mobile/components/word_request/item/editor_comment.dart';
import 'package:booqs_mobile/components/word_request/item/heading.dart';
import 'package:booqs_mobile/components/word_request/item/status.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';

class WordRequestItemMainContent extends StatelessWidget {
  const WordRequestItemMainContent({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WordRequestItemHeading(
          wordRequest: wordRequest,
        ),
        const SizedBox(
          height: 8,
        ),
        WordRequestItemStatus(
          wordRequest: wordRequest,
        ),
        const SizedBox(
          height: 24,
        ),
        WordRequestItemDiffs(
          wordRequest: wordRequest,
        ),
        WordRequestItemEditorComment(
          wordRequest: wordRequest,
        )
      ],
    );
  }
}
