import 'package:booqs_mobile/components/sentence/item/content.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/sentence_source.dart';
import 'package:booqs_mobile/components/button/small_green_button.dart';
import 'package:booqs_mobile/components/sentence/item/edit_button.dart';
import 'package:flutter/material.dart';

class SentenceSettingFormListItem extends StatelessWidget {
  const SentenceSettingFormListItem({Key? key, required this.sentence})
      : super(key: key);
  final Sentence sentence;

  @override
  Widget build(BuildContext context) {
    Widget source() {
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
            SentenceItemContent(sentence: sentence),
            const SizedBox(height: 8),
            source(),
            const SizedBox(height: 8),
            InkWell(
                onTap: () {
                  return Navigator.of(context).pop({'set': sentence});
                },
                child:
                    const SmallGreenButton(label: '設定する', icon: Icons.check)),
            SentenceItemEditButton(sentence: sentence, isShow: false),
          ]),
    );
  }
}
