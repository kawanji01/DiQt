import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/widgets/button/small_green_button.dart';
import 'package:booqs_mobile/widgets/sentence/edit_button.dart';
import 'package:flutter/material.dart';

class WordFormListSentence extends StatelessWidget {
  const WordFormListSentence({Key? key, required this.sentence})
      : super(key: key);
  final Sentence sentence;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(sentence.original,
                style: const TextStyle(
                    fontSize: 16, height: 1.6, color: Colors.black87)),
            const SizedBox(height: 8),
            Text(sentence.translation,
                style: const TextStyle(
                    fontSize: 16, height: 1.6, color: Colors.black87)),
            const SizedBox(height: 10),
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
