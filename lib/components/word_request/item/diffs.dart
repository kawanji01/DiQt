import 'package:booqs_mobile/components/word_request/item/entry_diff.dart';
import 'package:booqs_mobile/components/word_request/item/explanation_diff.dart';
import 'package:booqs_mobile/components/word_request/item/ipa_diff.dart';
import 'package:booqs_mobile/components/word_request/item/meaning_diff.dart';
import 'package:booqs_mobile/components/word_request/item/pos_diff.dart';
import 'package:booqs_mobile/components/word_request/item/reading_diff.dart';
import 'package:booqs_mobile/components/word_request/item/sentence_diff.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';

class WordRequestItemDiffs extends StatelessWidget {
  const WordRequestItemDiffs({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WordRequestEntryDiff(
          wordRequest: wordRequest,
        ),
        WordRequestItemReadingDiff(
          wordRequest: wordRequest,
        ),
        WordRequestItemPosDiff(
          wordRequest: wordRequest,
        ),
        WordRequestItemIpaDiff(
          wordRequest: wordRequest,
        ),
        WordRequestItemMeaningDiff(
          wordRequest: wordRequest,
        ),
        WordRequestItemSentenceDiff(
          wordRequest: wordRequest,
        ),
        WordRequestItemExplanationDiff(
          wordRequest: wordRequest,
        ),
      ],
    );
  }
}
