import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/pages/drill/show.dart';
import 'package:booqs_mobile/pages/drill/solved.dart';
import 'package:booqs_mobile/pages/drill/unsolved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillStatusTabs extends ConsumerWidget {
  const DrillStatusTabs({Key? key, required this.selected}) : super(key: key);
  final String selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int quizzesCount =
        ref.watch(drillProvider.select((drill) => drill!.quizzesCount));
    final int solvedQuizzesCount = ref.watch(drillSolvedQuizzesCountProvider);
    final int unsolvedQuizzesCount = quizzesCount - solvedQuizzesCount;

    const selectedStyle = TextStyle(
        color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold);
    const normalStyle = TextStyle(
        color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold);

    Widget unsolved() {
      final style = selected == 'unsolved' ? selectedStyle : normalStyle;
      final text = RichText(
        textAlign: TextAlign.center,
        text: TextSpan(text: '未解答\n($unsolvedQuizzesCount)', style: style),
      );
      return InkWell(
        onTap: () {
          DrillUnsolvedPage.push(context);
        },
        child: Container(alignment: Alignment.center, child: text),
      );
    }

    Widget solved() {
      final style = selected == 'solved' ? selectedStyle : normalStyle;
      final text = RichText(
        textAlign: TextAlign.center,
        text: TextSpan(text: '解答済\n($solvedQuizzesCount)', style: style),
      );
      return InkWell(
        onTap: () {
          DrillSolvedPage.push(context);
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
        text: TextSpan(text: 'すべて\n($quizzesCount)', style: style),
      );
      return InkWell(
        onTap: () {
          DrillShowPage.push(context);
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
