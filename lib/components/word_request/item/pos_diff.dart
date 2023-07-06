import 'package:booqs_mobile/components/shared/diff/lines.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';

class WordRequestItemPosDiff extends StatelessWidget {
  const WordRequestItemPosDiff({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    final String posTagName = wordRequest.posTag?.name ?? '';
    final String previousPosTagName = wordRequest.previousPosTag?.name ?? '';
    if (posTagName == previousPosTagName) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedItemLabel(text: t.words.pos_tag_id),
        const SizedBox(
          height: 8,
        ),
        SharedDiffLines(newText: posTagName, oldText: previousPosTagName),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
