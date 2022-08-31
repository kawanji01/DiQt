import 'package:booqs_mobile/data/provider/drill.dart';
import 'package:booqs_mobile/data/provider/drill_lap.dart';
import 'package:booqs_mobile/data/remote/drills.dart';
import 'package:booqs_mobile/models/drill.dart';
import 'package:booqs_mobile/models/drill_lap.dart';
import 'package:booqs_mobile/pages/drill/unsolved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrillLapUpdateScreen extends ConsumerWidget {
  const DrillLapUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Drill? drill = ref.watch(drillProvider);
    final DrillLap? drillLap = ref.watch(drillLapProvider);
    final int newLapNumber = drillLap!.clearsCount + 1;

    Future<void> _startNewLap() async {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      Map? resMap = await RemoteDrills.newLap(drill!.publicUid);
      EasyLoading.dismiss();
      if (resMap == null) return;
      final snackBar = SnackBar(content: Text('${resMap['message']}'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pop();
      ref.refresh(asyncDrillUnsolvedQuizzesProvider);
      DrillUnsolvedPage.push(context);
    }

    Widget _updateButton() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton.icon(
            icon: const Icon(
              Icons.thumb_up,
              color: Colors.white,
            ),
            label: const Text('OK',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            onPressed: () {
              _startNewLap();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(264, 48),
              primary: Colors.green,
            ),
          ),
        ),
      );
    }

    final explanation = Text(
        '解答済の問題をすべて未解答に戻して、$newLapNumber周目を始めます。\nよろしいですか？',
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87));

    return Container(
      height: 240,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // 閉じるボタンを下端に固定 ref: https://www.choge-blog.com/programming/flutter-bottom-button/
      child: Stack(
        children: [
          Column(children: [
            const SizedBox(height: 16),
            explanation,
            const SizedBox(height: 16),
          ]),
          _updateButton(),
        ],
      ),
    );
  }
}
