import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/components/sentence/item/tts_button.dart';
import 'package:booqs_mobile/components/shared/text_with_dict_link.dart';
import 'package:flutter/material.dart';

class SentenceItemContent extends StatelessWidget {
  const SentenceItemContent({Key? key, required this.sentence})
      : super(key: key);
  final Sentence sentence;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              TextWithDictLink(
                text: sentence.original,
                langNumber: sentence.langNumberOfOriginal,
                autoLinkEnabled: true,
                crossAxisAlignment: CrossAxisAlignment.start,
                dictionaryId: sentence.dictionaryId,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontColor: Colors.black87,
                selectable: true,
              ),
              const SizedBox(height: 8),
              Text(
                sentence.translation,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        ),
        SentenceItemTTSButton(
          sentence: sentence,
        ),
      ],
    );
  }
}
