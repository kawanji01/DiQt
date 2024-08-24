import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/components/drill/list_item.dart';
import 'package:booqs_mobile/components/user/resuming_drill_laps_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserResumingDrillLap extends ConsumerWidget {
  const UserResumingDrillLap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Drill? drill =
        ref.watch(currentUserProvider.select((user) => user?.drillInProgress));
    if (drill == null) return Container();

    // 解答中の問題集の一覧を表示するボタン
    final drillsInProgressButton = ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 40),
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
          builder: (context) => const UserResumingDrillLapsScreen(),
        );
      },
      icon: const Icon(Icons.bookmark, color: Colors.white),
      label: Text(
        t.drillLaps.view_more,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );

    return Container(
      margin: const EdgeInsets.only(top: 32, bottom: 48),
      child: Column(
        children: [
          HeadingMediumGreen(
              label: t.drillLaps.resume, icon: Icons.bookmark_border),
          DrillListItem(drill: drill),
          drillsInProgressButton,
        ],
      ),
    );
  }
}
