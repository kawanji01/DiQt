import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/sentence_source.dart';
import 'package:booqs_mobile/widgets/shared/text_with_dict_link.dart';
import 'package:flutter/material.dart';

class WordFormSentence extends StatelessWidget {
  const WordFormSentence({Key? key, required this.sentence}) : super(key: key);
  final Sentence sentence;

  @override
  Widget build(BuildContext context) {
    Widget _info() {
      final SentenceSource? source = sentence.sentenceSource;
      if (source == null) {
        return Text(
          'ID: ${sentence.id}',
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        );
      }
      return Text(
        '出典： ${source.title} / ID: ${sentence.id}',
        style: const TextStyle(fontSize: 12, color: Colors.black54),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        const SizedBox(height: 8),
        _info(),
      ],
    );
  }
}
