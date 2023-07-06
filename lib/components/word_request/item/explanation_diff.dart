import 'package:booqs_mobile/components/shared/diff/lines.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';

class WordRequestItemExplanationDiff extends StatelessWidget {
  const WordRequestItemExplanationDiff({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    final String explanation = wordRequest.explanation ?? '';
    final String previousExplanation = wordRequest.previousExplanation ?? '';
    if (explanation == previousExplanation) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedItemLabel(text: t.words.explanation),
        const SizedBox(
          height: 8,
        ),
        SharedDiffLines(
          oldText: previousExplanation,
          newText: explanation,
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
