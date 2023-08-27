import 'package:booqs_mobile/data/provider/drill_lap.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/components/button/large_green_button.dart';
import 'package:booqs_mobile/components/drill/lap_update_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillLapUpdateButton extends ConsumerWidget {
  const DrillLapUpdateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DrillLap? drillLap = ref.watch(drillLapProvider);
    if (drillLap == null) return Container();

    return Column(children: [
      const SizedBox(height: 32),
      Text(
        t.drills.clears_count(number: '${drillLap.clearsCount}'),
        style: const TextStyle(
            fontSize: 32, color: Colors.black54, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 32),
      InkWell(
        onTap: () {
          const screen = DrillLapUpdateScreen();
          Dialogs.slideFromBottomFade(screen);
        },
        child: LargeGreenButton(label: t.drills.new_lap, icon: null),
      ),
    ]);
  }
}
