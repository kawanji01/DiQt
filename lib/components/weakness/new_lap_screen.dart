import 'package:booqs_mobile/data/provider/weakness.dart';
import 'package:booqs_mobile/data/remote/weaknesses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessNewLapScreen extends ConsumerStatefulWidget {
  const WeaknessNewLapScreen({Key? key}) : super(key: key);

  @override
  WeaknessNewLapScreenState createState() => WeaknessNewLapScreenState();
}

class WeaknessNewLapScreenState extends ConsumerState<WeaknessNewLapScreen> {
  @override
  Widget build(BuildContext context) {
    Future<void> startNewLap() async {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      Navigator.of(context).pop();
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteWeaknesses.newLap();
      EasyLoading.dismiss();
      if (resMap == null) return;
      if (!mounted) return;

      const snackBar = SnackBar(content: Text('すべての問題を未正解に戻しました。'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      ref.invalidate(asyncUnsolvedWeaknessesProvider);
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
            label: const Text('OK',
                style: TextStyle(
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

    const explanation = Text('正解済の問題をすべて未正解に戻します。\nよろしいですか？',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87));

    return Container(
      height: 240,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // 閉じるボタンを下端に固定 ref: https://www.choge-blog.com/programming/flutter-bottom-button/
      child: Stack(
        children: [
          const Column(children: [
            SizedBox(height: 16),
            explanation,
            SizedBox(height: 16),
          ]),
          updateButton(),
        ],
      ),
    );
  }
}
