import 'package:booqs_mobile/models/answer_analysis.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:flutter/material.dart';

class QuizExplanationAnswerAnalysis extends StatelessWidget {
  const QuizExplanationAnswerAnalysis({Key? key, required this.answerAnalysis})
      : super(key: key);
  final AnswerAnalysis answerAnalysis;

  @override
  Widget build(BuildContext context) {
    final int answersCount = answerAnalysis.answerHistoriesCount;
    final int incorrectAnswersCount =
        answerAnalysis.incorrectAnswerHistoriesCount;
    final double correctAnswerRate = answerAnalysis.correctAnswerRate;

    Widget _answersCount() {
      if (answersCount == 0) {
        return const Text('まだ解答したことがありません。', style: TextStyle(fontSize: 16));
      }
      return Text(
        '回数数：$answersCount',
        style: const TextStyle(fontSize: 16),
      );
    }

    Widget _incorrectAnswersCount() {
      if (incorrectAnswersCount == 0) {
        return Container();
      }
      return Text('間違えた回数：$incorrectAnswersCount',
          style: const TextStyle(color: Colors.red, fontSize: 16));
    }

    Widget _correctAnswerRate() {
      if (correctAnswerRate == 0) {
        return Container();
      }
      Color color = Colors.blue;
      if (correctAnswerRate < 50) {
        color = Colors.red;
      }
      return Text('正答率：$correctAnswerRate',
          style: TextStyle(color: color, fontSize: 16));
    }

    return Column(
      children: [
        const SharedItemLabel(text: '解答分析'),
        const SizedBox(height: 8),
        _answersCount(),
        const SizedBox(height: 4),
        _incorrectAnswersCount(),
        const SizedBox(height: 4),
        _correctAnswerRate(),
      ],
    );
  }
}
