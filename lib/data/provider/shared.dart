import 'package:confetti/confetti.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// word, sentence, quizの編集画面で、他の画面に遷移させないためのフラグ

class SharedEditingContentState extends StateNotifier<bool> {
  SharedEditingContentState() : super(false);

  void onEdit() {
    state = true;
  }

  void offEdit() {
    state = false;
  }
}

final sharedEditingContentProvider =
    StateNotifierProvider<SharedEditingContentState, bool>(
        (ref) => SharedEditingContentState());

final confettiControllerProvider =
    Provider.autoDispose<ConfettiController>((ref) {
  final controller = ConfettiController(duration: const Duration(seconds: 10));
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
