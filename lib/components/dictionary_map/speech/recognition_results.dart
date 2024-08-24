import 'package:flutter/material.dart';

/// Displays the most recently recognized words and the sound level.
class RecognitionResults extends StatelessWidget {
  const RecognitionResults(
      {Key? key,
      required this.lastWords,
      required this.level,
      required this.startListening})
      : super(key: key);

  final String lastWords;
  final double level;
  final void Function() startListening;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                color: Theme.of(context).highlightColor.withOpacity(0.2),
                child: Center(
                  child: Text(
                    lastWords,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Positioned.fill(
                bottom: 10,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 64,
                    height: 64,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: .26,
                            spreadRadius: level * 1.5,
                            color: Colors.black.withOpacity(.05))
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.mic,
                        size: 32,
                      ),
                      onPressed: startListening,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
