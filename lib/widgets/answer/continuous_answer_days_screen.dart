import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/consts/sounds.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/models/answer_creator.dart';
import 'package:booqs_mobile/widgets/button/dialog_close_button.dart';
import 'package:booqs_mobile/widgets/exp/gained_exp_indicator.dart';
import 'package:booqs_mobile/widgets/shared/dialog_confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerContinuousAnswerDaysScreen extends ConsumerWidget {
  const AnswerContinuousAnswerDaysScreen(
      {Key? key, required this.answerCreator})
      : super(key: key);
  final AnswerCreator answerCreator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 開始経験値（初期 + 問題集周回報酬 + 解答日数報酬）
    final int initialExp = answerCreator.startPoint +
        answerCreator.lapClearPoint +
        answerCreator.answerDaysPoint;
    // 獲得経験値
    final int gainedExp = answerCreator.continuousAnswerDaysPoint;

    // 効果音
    final bool seEnabled = ref
        .watch(answerSettingProvider.select((setting) => setting!.seEnabled));
    if (seEnabled) {
      final AudioCache _cache = AudioCache(
        fixedPlayer: AudioPlayer(),
      );
      _cache.loadAll([continousSound]);
      _cache.play(continousSound);
    }
    //
    Widget _heading() {
      return Text('${answerCreator.continuousAnswerDaysCount}日連続解答',
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
