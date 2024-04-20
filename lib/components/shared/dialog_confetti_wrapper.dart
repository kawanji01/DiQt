import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

// 紙吹雪を全画面に表示するためのラッパー
// ref: https://chat.openai.com/share/8d797633-6ff1-407a-b95f-dc97c8d7b289
class DialogConfettiWrapper extends StatefulWidget {
  const DialogConfettiWrapper({super.key, required this.screen});
  final Widget screen;

  @override
  State<DialogConfettiWrapper> createState() => _DialogConfettiWrapperState();
}

class _DialogConfettiWrapperState extends State<DialogConfettiWrapper> {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 10));

  OverlayEntry? _overlayEntry;

  void _createOverlayEntry() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: true,
          minimumSize: const Size(10, 5),
          maximumSize: const Size(20, 10),
          numberOfParticles: 30,
          emissionFrequency: 0.1,
          gravity: 0.05,
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _createOverlayEntry();
      _confettiController.play();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.screen;
  }
}
