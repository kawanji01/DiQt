import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/services/sanitizer.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/widgets/drill/icon.dart';
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
    Widget _title() {
      return Text(drill.title,
          style: const TextStyle(fontSize: 12, color: Colors.black54));
    }

    Widget _question(quiz) {
      // DiQtリンク（[[text1|text2]]など）を取り除いてplain textに直す。
      String question = Sanitizer.removeDiQtLink(quiz.question);
      //String question = quiz.question;
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _title(),
        Text(
          question,
          style: const TextStyle(fontSize: 15),
        ),
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
