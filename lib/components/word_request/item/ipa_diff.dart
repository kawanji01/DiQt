import 'package:booqs_mobile/components/shared/diff/lines.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';

class WordRequestItemIpaDiff extends StatelessWidget {
  const WordRequestItemIpaDiff({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    final String ipa = wordRequest.ipa ?? '';
    final String previousIpa = wordRequest.previousIpa ?? '';
    if (ipa == previousIpa) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedItemLabel(
          text: t.words.ipa,
        ),
        const SizedBox(
          height: 8,
        ),
        SharedDiffLines(
          oldText: previousIpa,
          newText: ipa,
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
