// AudioPlayerを管理するStateNotifier
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioPlayerNotifier extends StateNotifier<AudioPlayer> {
  AudioPlayerNotifier() : super(AudioPlayer());

  Future<void> setSourceUrl(String url) async {
    await state.setSourceUrl(url);
  }

  Future<void> play() async {
    await state.seek(Duration.zero);
    await state.resume();
  }

  void stop() {
    state.stop();
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}

// AudioPlayerNotifierのProviderを作成するProviderを定義
final audioPlayerNotifierProvider =
    StateNotifierProvider<AudioPlayerNotifier, AudioPlayer>((ref) {
  return AudioPlayerNotifier();
});
