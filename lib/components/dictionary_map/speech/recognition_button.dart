import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

/// Display the current status of the listener
class SpeechRecognitionButton extends StatelessWidget {
  const SpeechRecognitionButton({
    super.key,
    required this.speech,
    required this.isStarting,
    required this.startListening,
    required this.stopListening,
  });

  final SpeechToText speech;
  final bool isStarting;
  final void Function() startListening;
  final void Function() stopListening;

  @override
  Widget build(BuildContext context) {
    Widget label() {
      // マイクボタンを押下したが、マイクがまだ起動していない場合
      if (isStarting && speech.isListening == false) {
        return const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        );
      }
      if (speech.isListening) {
        return Text(
          t.dictionaryMaps.stop_speech_recognition,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
        );
      } else {
        return Text(
          t.dictionaryMaps.start_speech_recognition,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
        );
      }
    }

    return Container(
      margin: const EdgeInsets.only(top: 32, bottom: 40),
      width: MediaQuery.of(context).size.width,
      height: 48,
      child: ElevatedButton(
        onPressed: isStarting && speech.isListening == false
            ? null
            : speech.isListening
                ? stopListening
                : startListening,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, //ボタンの背景色
        ),
        child: label(),
      ),
    );
  }
}
