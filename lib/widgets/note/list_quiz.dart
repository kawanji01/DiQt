import 'package:booqs_mobile/models/note.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/note/quiz_header.dart';
import 'package:booqs_mobile/widgets/quiz/content.dart';
import 'package:flutter/material.dart';

class NoteListQuiz extends StatelessWidget {
  const NoteListQuiz({Key? key, required this.note}) : super(key: key);
  final Note note;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = note.quiz;
    if (quiz == null) return const Text('Quiz does not exist.');

    final header = NoteQuizHeader(note: note);
    return QuizContent(
      quiz: quiz,
      header: header,
      isShow: false,
    );
  }
}
