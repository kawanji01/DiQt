import 'package:booqs_mobile/models/note.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/shared/markdown_with_diqt_link.dart';
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

      return Column(
        children: [
          // heading
          const Text('ヒント',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          // content
          Container(
            alignment: Alignment.centerLeft,
            child: MarkdownWithDictLink(
              text: hintText,
              dictionaryId: quiz.dictionaryId,
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 40),
        ],
      );
    }

    //
    Widget _note() {
      if (note == null) return Container();
      final String noteText = note?.content ?? '';

      return Column(
        children: [
          const Text('ノート',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            alignment: Alignment.centerLeft,
            child: MarkdownWithDictLink(
              text: noteText,
              dictionaryId: quiz.dictionaryId,
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
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
