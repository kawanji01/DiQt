import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/consts/sounds.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/button/dialog_close_button.dart';
import 'package:booqs_mobile/widgets/shared/dialog_confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerWeaknessClearScreen extends ConsumerWidget {
  const AnswerWeaknessClearScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      return const Text('素晴らしい！！\n苦手な問題をすべて解きました！！',
          style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange));
    }

    return Container(
      height: ResponsiveValues.dialogHeight(context),
      width: ResponsiveValues.dialogWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // 閉じるボタンを下端に固定 ref: https://www.choge-blog.com/programming/flutter-bottom-button/
      child: Stack(
        children: [
          Column(children: [
            const SizedBox(height: 16),
            _heading(),
          ]),
          const DialogCloseButton(),
          const DialogConfetti(),
        ],
      ),
    );
  }
}
