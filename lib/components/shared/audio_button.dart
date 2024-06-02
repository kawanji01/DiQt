import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioButton extends StatefulWidget {
  const AudioButton({super.key, required this.url});
  final String url;

  @override
  State<AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
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
      onPressed: () {
        try {
          _audioPlayer.play(UrlSource(widget.url),
              mode: PlayerMode.lowLatency, position: Duration.zero);
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
