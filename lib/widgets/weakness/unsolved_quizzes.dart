import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/weakness.dart';
import 'package:booqs_mobile/widgets/weakness/new_lap_button.dart';
import 'package:booqs_mobile/widgets/weakness/unsolved_quiz_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessUnsolvedQuizzes extends ConsumerWidget {
  const WeaknessUnsolvedQuizzes({Key? key, required this.weaknesses})
      : super(key: key);
  final List<Weakness> weaknesses;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /* final int weaknessesCount = ref.watch(currentUserProvider
        .select((user) => user == null ? 0 : user.weaknessesCount));

    // 苦手な問題がない場合
    if (weaknesses.isEmpty && weaknessesCount == 0) {
      return const Text('苦手な問題はありません',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black54,
              height: 4));
    } else if (weaknesses.isEmpty) {
      return const WeaknessNewLapButton();
    } */

    if (weaknesses.isEmpty) {
      return const WeaknessNewLapButton();
    }

    // 苦手な問題がある場合
    final List<Widget> list = [];
    for (Weakness weakness in weaknesses) {
      list.add(WeaknessUnsolvedQuizWrapper(weakness: weakness));
    }

    // ListViewはスクロールによって再ビルドされたりするので、Columnを使う。
    return Column(
      children: list,
    );
  }
}
