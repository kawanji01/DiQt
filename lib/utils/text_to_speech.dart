import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  static final FlutterTts _flutterTts = FlutterTts();
  static bool _iosAudioCategoryConfigured = false;
  static int _speakRequestVersion = 0;

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
    final int requestVersion = ++_speakRequestVersion;
    final String langCode = TextToSpeech.getLangCode(langNumber);
    // earphoneから音が出ない問題の対処 ref: https://github.com/dlutton/flutter_tts/issues/106
    if (Platform.isIOS && !_iosAudioCategoryConfigured) {
      await _flutterTts
          .setIosAudioCategory(IosTextToSpeechAudioCategory.playback, [
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        IosTextToSpeechAudioCategoryOptions.mixWithOthers,
        IosTextToSpeechAudioCategoryOptions.defaultToSpeaker
      ]);
      if (requestVersion != _speakRequestVersion) return;
      _iosAudioCategoryConfigured = true;
    }
    if (requestVersion != _speakRequestVersion) return;
    await _flutterTts.setLanguage(langCode);
    if (requestVersion != _speakRequestVersion) return;
    await _flutterTts.setSpeechRate(0.5);
    if (requestVersion != _speakRequestVersion) return;
    await _flutterTts.setVolume(1.0);
    if (requestVersion != _speakRequestVersion) return;
    await _flutterTts.setPitch(1.0);
    if (requestVersion != _speakRequestVersion) return;
    await _flutterTts.speak(speechText);
  }

  static Future<void> stop() async {
    _speakRequestVersion++;
    await _flutterTts.stop();
  }
}
