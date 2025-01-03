import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

// 紙吹雪
// ref: https://blog.dalt.me/2478
// ref: https://gist.github.com/derekedelaney/0bd36b370daceaf56712a22bd097cdc8
class DialogConfetti extends StatefulWidget {
  const DialogConfetti({super.key});

  @override
  State<DialogConfetti> createState() => _DialogConfettiState();
}

class _DialogConfettiState extends State<DialogConfetti> {
  // 紙吹雪
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 1));

  @override
  void initState() {
    super.initState();
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
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
    );
  }
}
