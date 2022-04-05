import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/quiz/explanation.dart';
import 'package:flutter/material.dart';

class QuizExplanationButton extends StatelessWidget {
  const QuizExplanationButton({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('解説をみる',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey)),
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          // showModalBottomSheetで表示される中身
          builder: (context) => QuizExplanation(quiz: quiz),
        );
      },
    );
  }
}
