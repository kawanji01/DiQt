import 'package:booqs_mobile/components/shared/diff/lines.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:flutter/material.dart';

class SentenceRequestTranslationDiff extends StatelessWidget {
  const SentenceRequestTranslationDiff(
      {super.key, required this.sentenceRequest});
  final SentenceRequest sentenceRequest;

  @override
  Widget build(BuildContext context) {
    final String translation = sentenceRequest.translation ?? '';
    final String previousTranslation =
        sentenceRequest.previousTranslation ?? '';

    Widget translationDiff() {
      if (translation == previousTranslation) {
        return Text(
          translation,
          style: const TextStyle(fontSize: 18, color: Colors.black87),
        );
      }
      return SharedDiffLines(
          oldText: previousTranslation, newText: translation);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedItemLabel(
          text: t.sentences.translation,
        ),
        const SizedBox(
          height: 8,
        ),
        translationDiff(),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
