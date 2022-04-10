import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/widgets/quiz/explanation/answer.dart';
import 'package:booqs_mobile/widgets/quiz/explanation/distractors.dart';
import 'package:booqs_mobile/widgets/quiz/explanation/question.dart';
import 'package:flutter/material.dart';

class QuizExplanationScreen extends StatefulWidget {
  const QuizExplanationScreen({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  State<QuizExplanationScreen> createState() => _QuizExplanationScreenState();
}

class _QuizExplanationScreenState extends State<QuizExplanationScreen> {
  @override
  Widget build(BuildContext context) {
    final Quiz quiz = widget.quiz;
    SizeConfig().init(context);
    final double grid = SizeConfig.blockSizeVertical ?? 0;
    final double height = grid * 80;

    // 80%の高さで表示させる
    return Container(
        height: height,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              QuizExplanationQuestion(quiz: quiz),
              QuizExplanationAnswer(quiz: quiz),
              QuizExplanationDistractors(quiz: quiz)
            ],
          ),
        ));
  }
}
