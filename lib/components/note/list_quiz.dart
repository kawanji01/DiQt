import 'package:booqs_mobile/components/note/item.dart';
import 'package:booqs_mobile/models/note.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/components/note/quiz_header.dart';
import 'package:booqs_mobile/components/quiz/item.dart';
import 'package:flutter/material.dart';

class NoteListQuiz extends StatelessWidget {
  const NoteListQuiz({Key? key, required this.note}) : super(key: key);
  final Note note;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = note.quiz;
    if (quiz == null) return const Text('Quiz does not exist.');

    return Column(children: [
      QuizItem(
        quiz: quiz,
        header: NoteQuizHeader(note: note),
        isShow: false,
      ),
      const SizedBox(
        height: 16,
      ),
      Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 3,
            ),
          ),
        ),
        child: NoteItem(quiz: quiz),
      ),
    ]);
  }
}
