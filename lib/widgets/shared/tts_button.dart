import 'package:booqs_mobile/utils/text_to_speech.dart';
import 'package:flutter/material.dart';

class TtsButton extends StatelessWidget {
  const TtsButton({Key? key, required this.speechText, this.langNumber})
      : super(key: key);

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

    return ElevatedButton(
      child: const Icon(Icons.volume_up),
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        onPrimary: Colors.white,
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.green,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      onPressed: () => {TextToSpeech.speak(langNumber, speechText)},
    );
  }
}
