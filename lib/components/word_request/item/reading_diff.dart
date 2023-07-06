import 'package:booqs_mobile/components/shared/diff/lines.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';

class WordRequestItemReadingDiff extends StatelessWidget {
  const WordRequestItemReadingDiff({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    final String reading = wordRequest.reading ?? '';
    final String previousReading = wordRequest.previousReading ?? '';
    if (reading == previousReading) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedItemLabel(text: t.words.reading),
        const SizedBox(
          height: 8,
        ),
        SharedDiffLines(
          oldText: previousReading,
          newText: reading,
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
