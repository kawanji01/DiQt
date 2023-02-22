import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/components/drill/lap_update_button.dart';
import 'package:booqs_mobile/components/drill/unsolved_quiz_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillUnsolvedQuizzes extends ConsumerWidget {
  const DrillUnsolvedQuizzes({Key? key, required this.quizzes})
      : super(key: key);
  final List<Quiz> quizzes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 未解答の問題一覧
    Widget quizItems(quizzes) {
      // 未解答の問題がなければ、周回ボタンを表示する。
      if (quizzes.isEmpty) return const DrillLapUpdateButton();

      final List<Widget> list = [];
      for (Quiz quiz in quizzes!) {
        list.add(DrillUnsolvedQuizWrapper(quiz: quiz));
      }
      return Column(
        children: list,
      );
    }

    // ListViewはスクロールによって再ビルドされたりするので、Columnを使う。
    return quizItems(quizzes);
  }
}
