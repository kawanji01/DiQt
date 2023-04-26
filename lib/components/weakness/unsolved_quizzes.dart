import 'package:booqs_mobile/models/weakness.dart';
import 'package:booqs_mobile/components/weakness/new_lap_button.dart';
import 'package:booqs_mobile/components/weakness/unsolved_quiz_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessUnsolvedQuizzes extends ConsumerWidget {
  const WeaknessUnsolvedQuizzes({Key? key, required this.weaknesses})
      : super(key: key);
  final List<Weakness> weaknesses;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
