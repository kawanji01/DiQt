import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/components/answer/effect_setting.dart';
import 'package:booqs_mobile/consts/sounds.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/button/dialog_close_button.dart';
import 'package:booqs_mobile/components/shared/dialog_confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerWeaknessClearScreen extends ConsumerStatefulWidget {
  const AnswerWeaknessClearScreen({Key? key}) : super(key: key);

  @override
  AnswerWeaknessClearScreenState createState() =>
      AnswerWeaknessClearScreenState();
}

class AnswerWeaknessClearScreenState
    extends ConsumerState<AnswerWeaknessClearScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 効果音
      if (ref.read(seEnabledProvider)) {
        audioPlayer.play(AssetSource(achievementSound),
            volume: 0.8, mode: PlayerMode.lowLatency);
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String message = t.answer.weakness_clear;
    final String description = t.answer.weakness_clear_description;
    return Container(
      height: ResponsiveValues.dialogHeight(context),
      width: ResponsiveValues.dialogWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // 閉じるボタンを下端に固定 ref: https://www.choge-blog.com/programming/flutter-bottom-button/
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 16),
              // heading
              Text(message,
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange)),
              const SizedBox(height: 16),
              // explanation
              Text(description,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
              const AnswerEffectSetting(),
            ]),
          ),
          const DialogCloseButton(),
          const DialogConfetti(),
        ],
      ),
    );
  }
}
