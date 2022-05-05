import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillStatusTabs extends ConsumerWidget {
  const DrillStatusTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String publicUid =
        ref.watch(drillProvider.select((drill) => drill!.publicUid));
    final int quizzesCount =
        ref.watch(drillProvider.select((drill) => drill!.quizzesCount));
    final int solvedQuizzesCount = ref.watch(drillSolvedQuizzesCountProvider);
    final int unsolvedQuizzesCount = quizzesCount - solvedQuizzesCount;

    Widget _unsolved() {
      final text = RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: '未解答\n($unsolvedQuizzesCount)',
            style: const TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      );
      return InkWell(
        onTap: () {
          print("");
        },
        child: Container(alignment: Alignment.center, child: text),
      );
    }

    Widget _solved() {
      final text = RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: '解答済\n($solvedQuizzesCount)',
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      );
      return InkWell(
        onTap: () {
          // 外部リンクダイアログを表示
          showDialog(
              context: context,
              builder: (context) {
                return ExternalLinkDialog(
                    redirectPath: 'drills/$publicUid/solved');
              });
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

    Widget _all() {
      final text = RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'すべて\n($quizzesCount)',
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      );
      return InkWell(
        onTap: () {
          // 外部リンクダイアログを表示
          showDialog(
              context: context,
              builder: (context) {
                return ExternalLinkDialog(redirectPath: 'drills/$publicUid');
              });
        },
        child: Container(alignment: Alignment.center, child: text),
      );
    }

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: _unsolved(),
        ),
        Expanded(flex: 1, child: _solved()),
        Expanded(flex: 1, child: _all()),
      ],
    );
  }
}
