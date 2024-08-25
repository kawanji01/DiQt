// AudioPlayerを管理するStateNotifier
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioPlayerNotifier extends StateNotifier<AudioPlayer> {
  AudioPlayerNotifier() : super(AudioPlayer());

  // 音声ファイルのURLを設定
  Future<void> setSourceUrl(String url) async {
    await state.setSourceUrl(url);
  }

  // 音量を設定
  Future<void> setVolume(double volume) async {
    await state.setVolume(volume);
  }

  // 再生
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
