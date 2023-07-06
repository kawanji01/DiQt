import 'package:booqs_mobile/components/shared/diff/text.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';

class WordRequestItemSentenceDiff extends StatelessWidget {
  const WordRequestItemSentenceDiff({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    final String original = wordRequest.sentence?.original ?? '';
    final String previousOriginal =
        wordRequest.previousSentence?.original ?? '';
    if (original == previousOriginal) {
      return Container();
    }

    final String translaion = wordRequest.sentence?.translation ?? '';
    final String previousTranslation =
        wordRequest.previousSentence?.translation ?? '';

    Widget diff() {
      if (translaion == previousTranslation) {
        return SharedDiffText(
          oldText: previousOriginal,
          newText: original,
          marked: false,
        );
      } else {
        return SharedDiffText(
          oldText: '$previousOriginal\n$previousTranslation',
          newText: '$original\n$translaion',
          marked: false,
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedItemLabel(text: t.words.sentence),
        const SizedBox(
          height: 8,
        ),
        diff(),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
