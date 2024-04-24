import 'package:booqs_mobile/components/sentence/item/content.dart';
import 'package:booqs_mobile/components/word/item/label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:flutter/material.dart';

class SentenceSettingSentencePreview extends StatelessWidget {
  const SentenceSettingSentencePreview({super.key, required this.sentence});
  final Sentence? sentence;

  @override
  Widget build(BuildContext context) {
    final Widget sentenceWidget = sentence == null
        ? Text(t.words.no_sentence,
            style: const TextStyle(
                fontSize: 16, height: 1.6, color: Colors.black87))
        : SentenceItemContent(sentence: sentence!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        WordItemLabel(text: t.words.sentence),
        const SizedBox(height: 8),
        sentenceWidget
      ],
    );
  }
}
