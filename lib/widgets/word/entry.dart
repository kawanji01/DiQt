import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/shared/tts_button.dart';
import 'package:flutter/material.dart';

class WordEntry extends StatelessWidget {
  const WordEntry({Key? key, required this.word}) : super(key: key);
  final Word? word;

  @override
  Widget build(BuildContext context) {
    if (word == null) return Container();

    // 左寄せできない問題の解決策としてdouble.infinityを設定する。https://techsmeme.com/flutter-text-left-right/
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        children: <Widget>[
          Text(
            word!.entry,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
          TtsButton(
              speechText: word!.entry, langNumber: word!.langNumberOfEntry),
        ],
      ),
    );
  }
}
