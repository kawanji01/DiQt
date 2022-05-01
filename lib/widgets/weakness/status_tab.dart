import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessStatusTab extends ConsumerWidget {
  const WeaknessStatusTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int unsolvedWeaknessesCount = ref.watch(currentUserProvider
        .select((user) => user == null ? 0 : user.unsolvedWeaknessesCount));
    final int weaknessesCount = ref.watch(currentUserProvider
        .select((user) => user == null ? 0 : user.weaknessesCount));

    final int solvedWeaknessesCount = weaknessesCount - unsolvedWeaknessesCount;

    Widget _unsolved() {
      final text = RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: '未正解\n($unsolvedWeaknessesCount)',
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
            text: '正解済\n($solvedWeaknessesCount)',
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
                return const ExternalLinkDialog(
                    redirectPath: 'weaknesses/solved');
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
            text: 'すべて\n($weaknessesCount)',
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
                return const ExternalLinkDialog(redirectPath: 'weaknesses/all');
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
