import 'package:audioplayers/audioplayers.dart';
import 'package:booqs_mobile/consts/sounds.dart';
import 'package:booqs_mobile/data/provider/answer_setting.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/level_calculator.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/button/dialog_close_button.dart';
import 'package:booqs_mobile/widgets/exp/exp_indicator.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booqs_mobile/widgets/answer/share_button.dart';

class ExpLevelUpScreen extends ConsumerStatefulWidget {
  const ExpLevelUpScreen({Key? key, required this.totalExp}) : super(key: key);
  final int totalExp;

  @override
  _ExpLevelUpScreenState createState() => _ExpLevelUpScreenState();
}

class _ExpLevelUpScreenState extends ConsumerState<ExpLevelUpScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 1));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bool seEnabled = ref.watch(seEnabledProvider);
      if (seEnabled) {
        // 効果音を鳴らす
        audioPlayer.play(AssetSource(levelUpSound), volume: 0.8);
        // 紙吹雪を降らせる
        _confettiController.play();
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int totalExp = widget.totalExp;

    Widget _shareButton() {
      final int level = LevelCalculator.levelForExp(totalExp).floor();
      final User? user = ref.watch(currentUserProvider);
      if (user == null) return Container();

      final String tweet = 'Lv.$levelに上がりました！！';
      final String url =
          '${DiQtURL.root(context)}/users/${user.publicUid}?level_up=$level';
      return AnswerShareButton(text: tweet, url: url);
    }

    Widget _confetti() {
      return Align(
        alignment: Alignment.topRight,
        child: ConfettiWidget(
          confettiController: _confettiController,
        ),
      );
    }

    return Container(
      height: ResponsiveValues.dialogHeight(context),
      width: ResponsiveValues.dialogWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // 閉じるボタンを下端に固定 ref: https://www.choge-blog.com/programming/flutter-bottom-button/
      child: Stack(
        children: [
          Column(children: [
            _confetti(),
            const SizedBox(height: 16),
            const Text('レベルアップ',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
            ExpExpIndicator(
              exp: totalExp,
            ),
            const SizedBox(height: 16),
            _shareButton()
          ]),
          const DialogCloseButton(),
          // 紙吹雪
          // ref: https://blog.dalt.me/2478
          // ref: https://gist.github.com/derekedelaney/0bd36b370daceaf56712a22bd097cdc8
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              minimumSize: const Size(10, 5),
              maximumSize: const Size(20, 10),
              // 一度に発射する数
              numberOfParticles: 30,
              emissionFrequency: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}
