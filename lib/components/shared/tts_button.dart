import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/utils/text_to_speech.dart';
import 'package:flutter/material.dart';

class TtsButton extends StatelessWidget {
  const TtsButton({super.key, required this.speechText, this.langNumber});

  final String speechText;
  final int? langNumber;

  @override
  Widget build(BuildContext context) {
    /* String _getLangCode() {
      switch (langNumber) {
        case 21:
          return 'en-US';
        case 44:
          return 'ja-JP';
        default:
          return 'en-US';
      }
    }

    FlutterTts flutterTts = FlutterTts();
    Future<void> _speak() async {
      await flutterTts.setLanguage(_getLangCode());
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(speechText);
    } */
    if (supportedTTSLangNumbers.contains(langNumber) == false) {
      return Container();
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        minimumSize: const Size(48, 48),
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.green,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      onPressed: () => {TextToSpeech.speak(langNumber, speechText)},
      child: const Icon(
        Icons.volume_up,
        size: 28.0,
      ),
    );
  }
}
