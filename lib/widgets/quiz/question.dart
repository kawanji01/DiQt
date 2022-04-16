import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/services/sanitizer.dart';
import 'package:booqs_mobile/widgets/drill/icon.dart';
import 'package:booqs_mobile/widgets/quiz/drill_title.dart';
import 'package:booqs_mobile/widgets/quiz/hint_button.dart';
import 'package:booqs_mobile/widgets/shared/tts_button.dart';
import 'package:flutter/material.dart';

class QuizQuestion extends StatelessWidget {
  const QuizQuestion(
      {Key? key,
      required this.quiz,
      required this.drill,
      required this.covering})
      : super(key: key);
  final Quiz quiz;
  final Drill drill;
  final bool covering;

  @override
  Widget build(BuildContext context) {
    Widget _ttsBtn() {
      if (quiz.questionReadAloud) {
        return Container(
          margin: const EdgeInsets.only(top: 4),
          alignment: Alignment.bottomLeft,
          child: TtsButton(
            speechText: quiz.question,
            langNumber: quiz.langNumberOfQuestion,
          ),
        );
      }
      return Container();
    }

    Widget _question(quiz) {
      // DiQtリンク（[[text1|text2]]など）を取り除いてplain textに直す。
      String question = Sanitizer.removeDiQtLink(quiz.question);
      //String question = quiz.question;
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        QuizDrillTitle(drill: drill),
        Text(
          question,
          style: const TextStyle(fontSize: 16),
        ),
        _ttsBtn(),
        QuizHintButton(quiz: quiz),
      ]);
    }

    return Row(
      children: [
        DrillIcon(drill: drill),
        Expanded(
          child: _question(quiz),
        ),
      ],
    );
  }
}
