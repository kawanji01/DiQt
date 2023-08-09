import 'package:booqs_mobile/components/shared/diff/diff_with_label.dart';
import 'package:booqs_mobile/components/word_request/item/senses.dart';
import 'package:booqs_mobile/components/word_request/item/sentence_diff.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
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
        SharedDiffWithLabel(
          label: t.words.entry,
          oldText: wordRequest.previousEntry,
          newText: wordRequest.entry,
          alwaysShow: true,
        ),
        SharedDiffWithLabel(
          label: t.words.reading,
          oldText: wordRequest.previousReading,
          newText: wordRequest.reading,
        ),
        SharedDiffWithLabel(
          label: t.words.pos_tag_id,
          oldText: wordRequest.previousPosTag?.name,
          newText: wordRequest.previousPosTag?.name,
        ),
        SharedDiffWithLabel(
          label: t.words.ipa,
          oldText: wordRequest.previousIpa,
          newText: wordRequest.ipa,
        ),
        SharedDiffWithLabel(
          label: t.words.meaning,
          oldText: wordRequest.previousMeaning,
          newText: wordRequest.meaning,
        ),
        WordRequestItemSentenceDiff(
          sentence: wordRequest.sentence,
          previousSentence: wordRequest.previousSentence,
        ),
        WordRequestItemSenses(
          wordRequest: wordRequest,
        ),
      ],
    );
  }
}
