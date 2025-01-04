import 'package:booqs_mobile/data/provider/audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioButton extends ConsumerWidget {
  const AudioButton({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioPlayerNotifier = ref.read(audioPlayerNotifierProvider.notifier);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        minimumSize: const Size(48, 48),
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.green,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      onPressed: () async {
        try {
          // 音声を再生
          await audioPlayerNotifier.setSourceUrl(url);
          await audioPlayerNotifier.setVolume(2.0);
          await audioPlayerNotifier.play();
        } catch (e) {
          print('Error playing audio: $e');
        }
      },
      child: const Icon(
        Icons.volume_up,
        size: 28.0,
        color: Colors.white,
      ),
    );
  }
}
