import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/button/small_outline_gray_button.dart';
import 'package:flutter/material.dart';

class QuizAnswerAnalysisButton extends StatelessWidget {
  const QuizAnswerAnalysisButton({Key? key, required this.quiz})
      : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    final AnswerAnalysis? answerAnalysis = quiz.answerAnalysis;

    return InkWell(
      onTap: () {},
      child: const SmallOutlineGrayButton(
          label: '分析をみる', icon: Icons.analytics_outlined),
    );
  }
}
