import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/sentence_source.dart';
import 'package:booqs_mobile/widgets/button/small_green_button.dart';
import 'package:booqs_mobile/widgets/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/widgets/sentence/edit_button.dart';
import 'package:booqs_mobile/widgets/shared/text_with_dict_link.dart';
import 'package:flutter/material.dart';

class WordFormListSentence extends StatelessWidget {
  const WordFormListSentence({Key? key, required this.sentence})
      : super(key: key);
  final Sentence sentence;

  @override
  Widget build(BuildContext context) {
    Widget _source() {
      final SentenceSource? sentenceSource = sentence.sentenceSource;
      if (sentenceSource == null) {
        return Text('ID: ${sentence.id}',
            style: const TextStyle(
                fontSize: 12, height: 1.6, color: Colors.black54));
      }
      return Text('出典: ${sentenceSource.title} / ID: ${sentence.id}',
          style: const TextStyle(
              fontSize: 12, height: 1.6, color: Colors.black54));
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextWithDictLink(
                text: sentence.original,
                langNumber: sentence.langNumberOfOriginal,
                autoLinkEnabled: true,
                crossAxisAlignment: CrossAxisAlignment.start,
                dictionaryId: sentence.dictionaryId,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontColor: Colors.green,
                selectable: true),
            const SizedBox(height: 8),
            Text(sentence.translation,
                style: const TextStyle(
                    fontSize: 16, height: 1.6, color: Colors.black87)),
            const SizedBox(height: 8),
            _source(),
            const SizedBox(height: 8),
            InkWell(
                onTap: () {
                  return Navigator.of(context).pop({'set': sentence});
                },
                child: const SmallGreenButton(label: '選ぶ', icon: Icons.check)),
            SentenceEditButton(sentence: sentence, isShow: false),
          ]),
    );
  }
}
