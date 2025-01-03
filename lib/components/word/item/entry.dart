import 'package:booqs_mobile/components/shared/audio_button.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/shared/tts_button.dart';
import 'package:flutter/material.dart';

class WordItemEntry extends StatelessWidget {
  const WordItemEntry({super.key, required this.word});
  final Word? word;

  @override
  Widget build(BuildContext context) {
    if (word == null) return Container();

    Widget pronunciationButton() {
      if (word!.entryAudioUrl == null || word!.entryAudioUrl == '') {
        return TtsButton(
            speechText: word!.ipa!, langNumber: word!.langNumberOfEntry);
      } else {
        return AudioButton(url: word!.entryAudioUrl!);
      }
    }

    // 左寄せできない問題の解決策としてdouble.infinityを設定する。https://techsmeme.com/flutter-text-left-right/
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        children: <Widget>[
          SelectableText(
            word!.entry,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          pronunciationButton(),
        ],
      ),
    );
  }
}
