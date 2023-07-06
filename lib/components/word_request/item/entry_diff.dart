import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';

class WordRequestEntryDiff extends StatelessWidget {
  const WordRequestEntryDiff({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SharedItemLabel(
          text: t.words.entry,
        ),
      ],
    );
  }
}
