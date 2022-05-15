import 'package:booqs_mobile/models/note.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:flutter/material.dart';

class QuizHintScreen extends StatelessWidget {
  const QuizHintScreen({Key? key, required this.quiz, required this.note})
      : super(key: key);
  final Quiz quiz;
  final Note? note;

  @override
  Widget build(BuildContext context) {
    //
    Widget _hint() {
      final String? hintText = quiz.hint;
      if (hintText == null) return Container();

      const heading = Text('ヒント',
          style: TextStyle(
              color: Colors.green, fontSize: 22, fontWeight: FontWeight.bold));
      // 内容
      final content = Container(
        alignment: Alignment.centerLeft,
        child: Text(hintText.trim(),
            style: const TextStyle(fontSize: 16, color: Colors.black87)),
      );
      return Column(
        children: [
          heading,
          const SizedBox(height: 16),
          content,
          const SizedBox(height: 40),
        ],
      );
    }

    //
    Widget _note() {
      if (note == null) return Container();
      final String noteText = note?.content ?? '';

      const heading = Text('ノート',
          style: TextStyle(
              color: Colors.green, fontSize: 22, fontWeight: FontWeight.bold));
      // 内容
      final content = Container(
        alignment: Alignment.centerLeft,
        child: Text(noteText.trim(),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            )),
      );

      return Column(
        children: [
          heading,
          const SizedBox(height: 16),
          content,
          const SizedBox(height: 40),
        ],
      );
    }

    return Container(
      width: double.infinity,
      height: 400,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: SingleChildScrollView(
          child: Column(
        children: [_hint(), _note()],
      )),
    );
  }
}
