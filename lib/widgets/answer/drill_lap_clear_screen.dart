import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/consts/sounds.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/widgets/button/dialog_close_button.dart';
import 'package:booqs_mobile/widgets/exp/gained_exp_indicator.dart';
import 'package:booqs_mobile/widgets/shared/dialog_confetti.dart';
import 'package:flutter/material.dart';

class AnswerDrillLapClearScreen extends StatelessWidget {
  const AnswerDrillLapClearScreen({Key? key, required this.answerCreator})
      : super(key: key);
  final AnswerCreator answerCreator;

  @override
  Widget build(BuildContext context) {
    // 開始経験値（基準 + 問題集周回報酬）
    final int initialExp = answerCreator.startPoint;
    // 獲得経験値
    final int gainedExp = answerCreator.lapClearPoint;
    // 周回情報
    final DrillLap drillLap = answerCreator.drillLap!;

    // AudioCacheを用いて再生
    final AudioCache _cache = AudioCache(
      fixedPlayer: AudioPlayer(),
    );
    _cache.loadAll([achievementSound]);
    _cache.play(achievementSound);

    Widget _heading() {
      return Text('${drillLap.numberOfLaps}周クリア',
          style: const TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange));
    }

    return Container(
      height: 400,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // 閉じるボタンを下端に固定 ref: https://www.choge-blog.com/programming/flutter-bottom-button/
      child: Stack(
        children: [
          Column(children: [
            const SizedBox(height: 16),
            _heading(),
            ExpGainedExpIndicator(
              initialExp: initialExp,
              gainedExp: gainedExp,
            ),
          ]),
          const DialogCloseButton(),
          const DialogConfetti(),
        ],
      ),
    );
  }
}
