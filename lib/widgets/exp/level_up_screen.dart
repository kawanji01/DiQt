import 'package:booqs_mobile/widgets/exp/exp_indicator.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ExpLevelUpScreen extends StatelessWidget {
  const ExpLevelUpScreen({Key? key, required this.totalExp}) : super(key: key);
  final int totalExp;

  @override
  Widget build(BuildContext context) {
    ConfettiController _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    _confettiController.play();

    Widget _heading() {
      return const Text('レベルアップ',
          style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange));
    }

    Widget _closeButton() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton.icon(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            label: const Text('閉じる',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(264, 40),
              primary: Colors.green,
            ),
          ),
        ),
      );
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
        height: 400,
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
            ]),
            _closeButton(),
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
