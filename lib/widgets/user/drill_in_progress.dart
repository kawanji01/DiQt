import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/widgets/drill/card.dart';
import 'package:booqs_mobile/widgets/user/drills_in_progress_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDrillInProgress extends ConsumerWidget {
  const UserDrillInProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Drill? drill =
        ref.watch(currentUserProvider.select((user) => user?.drillInProgress));
    if (drill == null) return Container();

    final heading = RichText(
        text: const TextSpan(children: [
      WidgetSpan(
        child: Icon(
          Icons.bookmark_border,
          color: Colors.green,
          size: 28.0,
        ),
      ),
      TextSpan(
          text: ' 続きから',
          style: TextStyle(
              color: Colors.green,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 2))
    ]));

    // 解答中の問題集の一覧を表示するボタン
    final drillsInProgressButton = ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity,
            40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
      ),
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)),
          ),
          // showModalBottomSheetで表示される中身
          builder: (context) => const UserDrillsInProgressScreen(),
        );
      },
      icon: const Icon(Icons.bookmark, color: Colors.white),
      label: const Text(
        'もっと見る',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );

    return Container(
      margin: const EdgeInsets.only(top: 32, bottom: 48),
      child: Column(
        children: [
          heading,
          DrillCard(drill: drill),
          drillsInProgressButton,
        ],
      ),
    );
  }
}
