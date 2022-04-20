import 'package:booqs_mobile/models/note.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:flutter/material.dart';

class QuizHintButton extends StatelessWidget {
  const QuizHintButton({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    final Note? note = quiz.note;
    final bool hintBlank = quiz.hint == null || quiz.hint == '';
    final bool noteBlank = note == null || note.content == '';
    if (hintBlank && noteBlank) return Container();

    Widget _hint() {
      if (hintBlank) return Container();

      final heading = RichText(
          text: const TextSpan(children: [
        WidgetSpan(
          child: Icon(
            Icons.lightbulb_outline_sharp,
            color: Colors.green,
            size: 24.0,
          ),
        ),
        TextSpan(
            text: ' ヒント',
            style: TextStyle(
                color: Colors.green, fontSize: 22, fontWeight: FontWeight.bold))
      ]));
      return Column(
        children: [
          heading,
          const SizedBox(height: 16),
          Text(quiz.hint!,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 16, color: Colors.black87)),
        ],
      );
    }

    Widget _note() {
      if (noteBlank) return Container();
      final heading = RichText(
          text: const TextSpan(children: [
        WidgetSpan(
          child: Icon(
            Icons.note,
            color: Colors.green,
            size: 24.0,
          ),
        ),
        TextSpan(
            text: ' ノート',
            style: TextStyle(
                color: Colors.green, fontSize: 22, fontWeight: FontWeight.bold))
      ]));
      return Column(
        children: [
          heading,
          const SizedBox(height: 16),
          Text(note.content,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              )),
        ],
      );
    }

    void _showDialog() {
      final Widget screen = Container(
        height: 400,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SingleChildScrollView(
            child: Column(
          children: [_hint(), const SizedBox(height: 40), _note()],
        )),
      );
      Dialogs.slideFromBottomFade(screen);
    }

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Colors.white70,
        minimumSize: const Size(80, 32),
      ),
      onPressed: () => {_showDialog()},
      icon: const Icon(Icons.lightbulb_outline_sharp, color: Colors.black87),
      label: const Text(
        'ヒント',
        style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black87),
      ),
    );
  }
}
