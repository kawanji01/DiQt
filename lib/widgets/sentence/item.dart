import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/widgets/sentence/tts_button.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/shared/text_with_dict_link.dart';
import 'package:flutter/material.dart';

class SentenceItem extends StatelessWidget {
  const SentenceItem({Key? key, required this.sentence}) : super(key: key);
  final Sentence sentence;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SharedItemLabel(text: '例文'),
        const SizedBox(height: 16),
        TextWithDictLink(
          text: sentence.original,
          langNumber: sentence.langNumberOfOriginal,
          autoLinkEnabled: true,
          crossAxisAlignment: CrossAxisAlignment.start,
          dictionaryId: sentence.dictionaryId,
        ),
        SentenceTTSButton(
          sentence: sentence,
        ),
        const SizedBox(height: 32),
        const SharedItemLabel(text: '訳'),
        const SizedBox(height: 16),
        Text(
          sentence.translation,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }
}
