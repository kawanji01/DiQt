import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/note.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/components/quiz/item/hint_screen.dart';
import 'package:flutter/material.dart';

class QuizItemHintButton extends StatelessWidget {
  const QuizItemHintButton({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    final Note? note = quiz.note;
    final bool hintBlank = quiz.hint == null || quiz.hint == '';
    final bool noteBlank = note == null || note.content == '';
    if (hintBlank && noteBlank) return Container();

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white70,
        minimumSize: const Size(80, 32),
      ),
      onPressed: () {
        final Widget screen = QuizItemHintScreen(quiz: quiz, note: note);
        Dialogs.normal(screen);
      },
      icon: const Icon(Icons.lightbulb_outline_sharp, color: Colors.black87),
      label: Text(
        t.quizzes.hint,
        style:
            const TextStyle(fontWeight: FontWeight.w700, color: Colors.black87),
      ),
    );
  }
}
