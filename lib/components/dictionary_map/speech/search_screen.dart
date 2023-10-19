import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/components/dictionary_map/speech/recognition_results.dart';
import 'package:booqs_mobile/components/dictionary_map/speech/language_options.dart';
import 'package:booqs_mobile/components/dictionary_map/speech/recognition_button.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/consts/sounds.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class DictionaryMapSpeechSearchScreen extends StatefulWidget {
  const DictionaryMapSpeechSearchScreen(
      {super.key, required this.keywordController, required this.dictionary});
  final TextEditingController keywordController;
  final Dictionary dictionary;

  @override
  State<DictionaryMapSpeechSearchScreen> createState() =>
      _DictionaryMapSpeechSearchScreenState();
}

class _DictionaryMapSpeechSearchScreenState
    extends State<DictionaryMapSpeechSearchScreen> {
  // 画面を閉じる処理を実行したかどうか。
  bool _isClosing = false;
  // 音声認識のスタートボタンを押下したかどうか。押下と実際の音声認識が始まる間にはラグがあるので、ボタンが押下されたタイミングを記録しておく。
  bool _isStarting = false;
  // マイクスタートの効果音
  final _audioPlayer = AudioPlayer();
  bool _hasSpeech = false;
  final bool _logEvents = false;
  final bool _onDevice = false;
  final int _pauseFor = 3;
  final int _listenFor = 30;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  /// This initializes SpeechToText. That only has to be done
  /// once per application, though calling it again is harmless
  /// it also does nothing. The UX of the sample app ensures that
  /// it can only be called once.
  Future<void> initSpeechState() async {
    _logEvent('Initialize');
    try {
      var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: _logEvents,
      );
      if (hasSpeech) {
        await initLocale();
      }
      if (!mounted) return;

      setState(() {
        _hasSpeech = hasSpeech;
      });
    } catch (e) {
      setState(() {
        lastError = 'Speech recognition failed: ${e.toString()}';
        _hasSpeech = false;
      });
    }
  }

  Future<void> initLocale() async {
    // Get the list of languages installed on the supporting platform so they
    // can be displayed in the UI for selection by the user.
    _localeNames = await speech.locales();
    final Dictionary dictionary = widget.dictionary;
    final String langCode = dictionary.langCodeOfEntry();
    LocaleName? currentLocale;
    // firstWhereは、該当する要素がない場合にStateErrorがスローされる。
    try {
      currentLocale = _localeNames.firstWhere(
        (element) => element.localeId.contains(langCode),
      );
    } catch (e) {
      // print('No matching locale found: $e');
      currentLocale = null;
    }
    if (currentLocale != null) {
      _currentLocaleId = currentLocale.localeId;
    } else {
      currentLocale = await speech.systemLocale();
      _currentLocaleId = currentLocale?.localeId ?? '';
    }
  }

  // 画面が開いている場合にのみ、画面を閉じる（二重にpopして画面がホワイトアウトするのを防ぐ）
  void closeScreen() {
    if (_isClosing) return;

    setState(() => _isClosing = true);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_hasSpeech == false) {
      return Column(
        children: [
          const LoadingSpinner(),
          Text(lastError),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          t.dictionaryMaps.search_by_speech,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(
          height: 16,
        ),
        SpeechLanguageOptions(_currentLocaleId, _switchLang, _localeNames),
        const SizedBox(
          height: 32,
        ),
        Expanded(
          flex: 4,
          child: RecognitionResults(
            lastWords: lastWords,
            level: level,
            startListening: startListening,
          ),
        ),
        SpeechRecognitionButton(
          speech: speech,
          startListening: startListening,
          stopListening: stopListening,
          isStarting: _isStarting,
        ),
      ],
    );
  }

  // This is called each time the users wants to start a new speech
  // recognition session
  Future<void> startListening() async {
    if (_isStarting) return;
    _logEvent('start listening');
    setState(() {
      _isStarting = true;
    });
    lastWords = '';
    lastError = '';
    // Note that `listenFor` is the maximum, not the minimum, on some
    // systems recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    await speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: _listenFor),
      pauseFor: Duration(seconds: _pauseFor),
      partialResults: true,
      localeId: _currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      cancelOnError: true,
      listenMode: ListenMode.confirmation,
      onDevice: _onDevice,
    );
    // 音声認識開始の効果音
    _audioPlayer.play(AssetSource(micStartSound), volume: 0.8);
    setState(() {});
  }

  void stopListening() {
    _logEvent('stop');
    speech.stop();
    widget.keywordController.text = lastWords;
    setState(() {
      level = 0.0;
    });
    closeScreen();
  }

  void cancelListening() {
    _logEvent('cancel');
    speech.cancel();
    setState(() {
      level = 0.0;
      _isStarting = false;
    });
  }

  /// This callback is invoked each time new recognition results are
  /// available after `listen` is called.
  void resultListener(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      lastWords = result.recognizedWords;
    });
    // 音声認識が終了したら、検索フォームに認識した言葉を入力して、画面を閉じて検索結果を表示する。
    if (result.finalResult) {
      widget.keywordController.text = result.recognizedWords;
      closeScreen();
    }
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = status;
    });
  }

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    debugPrint(selectedVal);
  }

  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      debugPrint('$eventTime $eventDescription');
    }
  }
}
