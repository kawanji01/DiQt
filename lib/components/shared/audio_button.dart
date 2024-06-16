import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioButton extends StatefulWidget {
  const AudioButton({super.key, required this.url});
  final String url;

  @override
  State<AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    // Create the audio player.
    _audioPlayer = AudioPlayer();

    // Set the release mode to keep the source after playback has completed.
    _audioPlayer.setReleaseMode(ReleaseMode.stop);

    // Preload the audio source.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await _audioPlayer.setSourceUrl(widget.url);
        // Androidだと一度しか音声が再生されなくなるのでコメントアウト
        // ref; https://pub.dev/documentation/audioplayers/latest/audioplayers/PlayerMode.html
        // await _audioPlayer.setPlayerMode(PlayerMode.lowLatency);
      } catch (e) {
        print('Error setting audio source: $e');
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          // Seek to the beginning before playing.
          await _audioPlayer.seek(Duration.zero);
          // Use resume instead of play to continue from the start.
          await _audioPlayer.resume();
        } catch (e) {
          print('Error playing audio: $e');
        }
      },
      child: const Icon(
        Icons.volume_up,
        size: 28.0,
      ),
    );
  }
}
