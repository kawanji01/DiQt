import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/widgets/drill/lap_update_button.dart';
import 'package:booqs_mobile/widgets/drill/status_tabs.dart';
import 'package:booqs_mobile/widgets/drill/unsolved_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillUnsolvedFeed extends ConsumerWidget {
  const DrillUnsolvedFeed({Key? key, required this.quizzes}) : super(key: key);
  final List<Quiz>? quizzes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 未解答の問題一覧
    Widget _quizItems(quizzes) {
      // 未解答の問題がなければ、周回ボタンを表示する。
      if (quizzes.isEmpty) return const DrillLapUpdateButton();

      final List<Widget> list = [];
      for (Quiz quiz in quizzes!) {
        list.add(DrillUnsolvedWrapper(quiz: quiz));
      }
      return Column(
        children: list,
      );
    }

    // ListViewはスクロールによって再ビルドされたりするので、Columnを使う。
    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: 32),
        const DrillStatusTabs(),
        const SizedBox(height: 8),
        _quizItems(quizzes),
      ]),
    );
  }
}
