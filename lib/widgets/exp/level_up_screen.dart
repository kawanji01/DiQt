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

class ExpLevelUpScreen extends ConsumerWidget {
  const ExpLevelUpScreen({Key? key, required this.totalExp}) : super(key: key);
  final int totalExp;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ConfettiController _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    _confettiController.play();

    Widget _heading() {
      return const Text('レベルアップ',
          style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange));
    }

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

    Widget _modal() {
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
              _heading(),
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

    return _modal();
  }
}
