import 'package:booqs_mobile/components/shared/diff/lines.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';

class WordRequestEntryDiff extends StatelessWidget {
  const WordRequestEntryDiff({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    final String entry = wordRequest.entry ?? '';
    final String previousEntry = wordRequest.previousEntry ?? '';

    Widget entryDiff() {
      if (entry == previousEntry) {
        return Text(
          entry,
          style: const TextStyle(fontSize: 18, color: Colors.black87),
        );
      }
      return SharedDiffLines(oldText: previousEntry, newText: entry);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedItemLabel(
          text: t.words.entry,
        ),
        const SizedBox(
          height: 8,
        ),
        entryDiff(),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
