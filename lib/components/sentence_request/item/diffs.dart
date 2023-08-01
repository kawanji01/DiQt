import 'package:booqs_mobile/components/shared/diff/diff_with_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:flutter/material.dart';

class SentenceRequestItemDiffs extends StatelessWidget {
  const SentenceRequestItemDiffs({super.key, required this.sentenceRequest});
  final SentenceRequest sentenceRequest;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedDiffWithLabel(
          label: t.sentences.original,
          oldText: sentenceRequest.previousOriginal,
          newText: sentenceRequest.original,
          alwaysShow: true,
        ),
        SharedDiffWithLabel(
          label: t.sentences.translation,
          oldText: sentenceRequest.previousTranslation,
          newText: sentenceRequest.translation,
          alwaysShow: true,
        ),
        SharedDiffWithLabel(
          label: t.sentences.explanation,
          oldText: sentenceRequest.previousExplanation,
          newText: sentenceRequest.explanation,
        ),
      ],
    );
  }
}
