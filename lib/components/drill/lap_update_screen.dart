import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/data/remote/drills.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/pages/drill/unsolved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillLapUpdateScreen extends ConsumerStatefulWidget {
  const DrillLapUpdateScreen({super.key});

  @override
  DrillLapUpdateScreenState createState() => DrillLapUpdateScreenState();
}

class DrillLapUpdateScreenState extends ConsumerState<DrillLapUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    final Drill? drill = ref.watch(drillProvider);

    Future<void> startNewLap() async {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      Map? resMap = await RemoteDrills.newLap(drill!.publicUid);
      EasyLoading.dismiss();
      if (resMap == null) return;
      if (!context.mounted) return;
      final snackBar = SnackBar(content: Text(t.drills.new_lap_started));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pop();
      ref.invalidate(asyncDrillUnsolvedQuizzesProvider);
      DrillUnsolvedPage.push(context);
    }

    Widget updateButton() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton.icon(
            icon: const Icon(
              Icons.thumb_up,
              color: Colors.white,
            ),
            label: Text(t.shared.ok,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            onPressed: () {
              startNewLap();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(264, 48),
              backgroundColor: Colors.green,
            ),
          ),
        ),
      );
    }

    return Container(
      height: 240,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // 閉じるボタンを下端に固定 ref: https://www.choge-blog.com/programming/flutter-bottom-button/
      child: Stack(
        children: [
          Column(children: [
            const SizedBox(height: 16),
            Text(t.drills.new_lap_description,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
            const SizedBox(height: 16),
          ]),
          updateButton(),
        ],
      ),
    );
  }
}
