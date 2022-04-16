import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  // 読み上げのための言語コードを取得する
  static String getLangCode(int? langNumber) {
    switch (langNumber) {
      case 21:
        return 'en-US';
      case 44:
        return 'ja-JP';
      default:
        return 'en-US';
    }
  }

  // 読み上げる
  static Future<void> speak(int? langNumber, String speechText) async {
    final FlutterTts flutterTts = FlutterTts();
    final String langCode = TextToSpeech.getLangCode(langNumber);
    await flutterTts.setLanguage(langCode);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(speechText);
  }
}
