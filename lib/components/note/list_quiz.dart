import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/note.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/components/note/quiz_header.dart';
import 'package:booqs_mobile/components/quiz/item.dart';
import 'package:flutter/material.dart';

class NoteListQuiz extends StatelessWidget {
  const NoteListQuiz({super.key, required this.note});
  final Note note;

  @override
  Widget build(BuildContext context) {
    final Quiz? quiz = note.quiz;
    if (quiz == null) return Text(t.shared.no_name_found(name: t.notes.note));

    return QuizItem(
      quiz: quiz,
      header: NoteQuizHeader(note: note),
      isShow: false,
    );
  }
}
