import 'package:booqs_mobile/components/drill/thumbnail.dart';
import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/drill/unsolved.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DrillListItem extends ConsumerWidget {
  const DrillListItem({super.key, required this.drill});
  final Drill drill;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1,000のようなdelimiterを使って解答数を整形する。参考： https://stackoverflow.com/questions/62580280/how-to-format-numbers-as-thousands-separators-in-dart

    String answerHistoriesCountText = '';
    // 1000以下の回答数は表示しない。
    if (drill.answerHistoriesCount > 1000) {
      final formatter = NumberFormat('#,###,000');
      final answerHistoriesCount = formatter.format(drill.answerHistoriesCount);
      answerHistoriesCountText = t.drills.answers(number: answerHistoriesCount);
    }
    final DrillLap? drillLap = drill.drillLap;

    // Drillページに遷移
    void moveToDrillPage(drill) {
      final User? user = ref.watch(currentUserProvider);
      if (user == null) {
        final snackBar = SnackBar(content: Text(t.shared.login_recommendation));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        UserMyPage.push(context);
      } else {
        ref.read(drillProvider.notifier).state = drill;
        DrillUnsolvedPage.push(context);
      }
    }

    Widget subtitle() {
      if (drillLap == null) {
        return Text(
          answerHistoriesCountText,
          style: TextStyle(color: Colors.black.withValues(alpha: 0.6)),
        );
      }
      return Text(
        '${answerHistoriesCountText == '' ? '' : '$answerHistoriesCountText / '}${t.drills.clears_count(number: drillLap.clearsCount)}',
        style: TextStyle(color: Colors.black.withValues(alpha: 0.6)),
      );
    }

    // カードデザインの参考： https://material.io/components/cards/flutter
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        splashColor: Colors.green.withAlpha(30),
        onTap: () {
          moveToDrillPage(drill);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Container(
                padding: const EdgeInsets.only(top: 8),
                child: Text(drill.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              subtitle: subtitle(),
            ),
            DrillThumbnail(drill: drill, drillLap: drillLap),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16.0, left: 16, top: 16, bottom: 32),
              child: Text(
                drill.introduction,
                style: TextStyle(color: Colors.black.withValues(alpha: 0.6)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
