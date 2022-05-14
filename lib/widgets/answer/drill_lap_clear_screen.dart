import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/consts/sounds.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/widgets/answer/share_button.dart';
import 'package:booqs_mobile/widgets/button/dialog_close_button.dart';
import 'package:booqs_mobile/widgets/exp/gained_exp_indicator.dart';
import 'package:booqs_mobile/widgets/shared/dialog_confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerDrillLapClearScreen extends ConsumerWidget {
  const AnswerDrillLapClearScreen({Key? key, required this.answerCreator})
      : super(key: key);
  final AnswerCreator answerCreator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 開始経験値（基準 + 問題集周回報酬）
    final int initialExp = answerCreator.startPoint;
    // 獲得経験値
    final int gainedExp = answerCreator.lapClearPoint;
    // 周回情報
    final DrillLap drillLap = answerCreator.drillLap!;
    // 記録
    final int counter = drillLap.numberOfLaps ?? 0;
    // 効果音
    final bool seEnabled = ref.watch(seEnabledProvider);
    if (seEnabled) {
      final AudioCache _cache = AudioCache(
        fixedPlayer: AudioPlayer(),
      );
      _cache.loadAll([achievementSound]);
      _cache.play(achievementSound);
    }

    Widget _heading() {
      return Text('$counter周クリア',
          style: const TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange));
    }

    Widget _twitterShareButton() {
      final User? user = ref.watch(currentUserProvider);
      if (user == null) return Container();
      final Drill? drill = ref.watch(drillProvider);
      if (drill == null) return Container();

      final String tweet = '「${drill.title}」を$counter周クリアしました！';
      final String url =
          '${DiQtURL.root(context)}/users/${user.publicUid}?type=all_solved';

      return AnswerShareButton(text: tweet, url: url);
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
            const SizedBox(height: 16),
            _twitterShareButton()
          ]),
          const DialogCloseButton(),
          const DialogConfetti(),
        ],
      ),
    );
  }
}
