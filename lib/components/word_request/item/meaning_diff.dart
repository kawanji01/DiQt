import 'package:booqs_mobile/components/shared/diff/lines.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';

class WordRequestItemMeaningDiff extends StatelessWidget {
  const WordRequestItemMeaningDiff({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    final String meaning = wordRequest.meaning ?? '';
    final String previousMeaning = wordRequest.previousMeaning ?? '';

    if (meaning == previousMeaning) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedItemLabel(
          text: t.words.meaning,
        ),
        const SizedBox(
          height: 8,
        ),
        SharedDiffLines(
          oldText: previousMeaning,
          newText: meaning,
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
