import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/pages/weakness/index.dart';
import 'package:booqs_mobile/pages/weakness/solved.dart';
import 'package:booqs_mobile/pages/weakness/unsolved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessStatusTabs extends ConsumerWidget {
  const WeaknessStatusTabs({Key? key, required this.selected})
      : super(key: key);
  final String selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int unsolvedWeaknessesCount = ref.watch(currentUserProvider
        .select((user) => user == null ? 0 : user.unsolvedWeaknessesCount));
    final int weaknessesCount = ref.watch(currentUserProvider
        .select((user) => user == null ? 0 : user.weaknessesCount));

    final int solvedWeaknessesCount = weaknessesCount - unsolvedWeaknessesCount;

    const selectedStyle = TextStyle(
        color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold);
    const normalStyle = TextStyle(
        color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold);

    Widget unsolved() {
      final style = selected == 'unsolved' ? selectedStyle : normalStyle;
      final text = RichText(
        textAlign: TextAlign.center,
        text: TextSpan(text: '未正解\n($unsolvedWeaknessesCount)', style: style),
      );
      return InkWell(
        onTap: () {
          WeaknessUnsolvedPage.push(context);
        },
        child: Container(alignment: Alignment.center, child: text),
      );
    }

    Widget solved() {
      final style = selected == 'solved' ? selectedStyle : normalStyle;
      final text = RichText(
        textAlign: TextAlign.center,
        text: TextSpan(text: '正解済\n($solvedWeaknessesCount)', style: style),
      );
      return InkWell(
        onTap: () {
          WeaknessSolvedPage.push(context);
        },
        child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(width: 0.5, color: Colors.black54),
                right: BorderSide(width: 0.5, color: Colors.black54),
              ),
            ),
            child: text),
      );
    }

    Widget all() {
      final style = selected == 'all' ? selectedStyle : normalStyle;
      final text = RichText(
        textAlign: TextAlign.center,
        text: TextSpan(text: 'すべて\n($weaknessesCount)', style: style),
      );
      return InkWell(
        onTap: () {
          WeaknessIndexPage.push(context);
        },
        child: Container(alignment: Alignment.center, child: text),
      );
    }

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: unsolved(),
        ),
        Expanded(flex: 1, child: solved()),
        Expanded(flex: 1, child: all()),
      ],
    );
  }
}
