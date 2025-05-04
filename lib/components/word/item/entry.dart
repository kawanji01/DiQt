import 'package:booqs_mobile/components/shared/audio_button.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/shared/tts_button.dart';
import 'package:booqs_mobile/consts/language.dart';
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

    final bool isRTL =
        rightToLeftScriptsNumbers.contains(word!.langNumberOfEntry);

    return SizedBox(
      width: double.infinity,
      child: Wrap(
        children: <Widget>[
          SelectableText(
            word!.entry,
            textAlign: isRTL ? TextAlign.right : TextAlign.left,
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
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
