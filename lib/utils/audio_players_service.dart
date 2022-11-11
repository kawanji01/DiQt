import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/consts/sounds.dart';

class AudioPlayersService {
  //
  static void playContinousSound() {
    play(continousSound);
  }

  static void playAchievementSound() {
    play(achievementSound);
  }

  static void playLevelUpSound() {
    play(levelUpSound);
  }

  // 効果音を鳴らす
  static void play(String sound) {
    final AudioCache _cache = AudioCache(
      fixedPlayer: AudioPlayer(),
    );
    _cache.loadAll([sound]);
    // マナーモードでは音を出さない。 ref: https://zenn.dev/asteroid/articles/3021e4a64a6970
    _cache.play(sound, volume: 0.8, isNotification: true);
  }
}
