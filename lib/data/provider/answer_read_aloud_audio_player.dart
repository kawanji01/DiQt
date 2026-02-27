import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerReadAloudAudioPlayerNotifier extends StateNotifier<AudioPlayer> {
  AnswerReadAloudAudioPlayerNotifier() : super(AudioPlayer());
  int _requestVersion = 0;

  Future<void> playUrl(String url) async {
    final int requestVersion = ++_requestVersion;
    await state.stop();
    if (requestVersion != _requestVersion) return;
    await state.play(UrlSource(url), volume: 2.0);
  }

  void stop() {
    _requestVersion++;
    state.stop();
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}

final answerReadAloudAudioPlayerProvider =
    StateNotifierProvider<AnswerReadAloudAudioPlayerNotifier, AudioPlayer>(
  (ref) => AnswerReadAloudAudioPlayerNotifier(),
);
