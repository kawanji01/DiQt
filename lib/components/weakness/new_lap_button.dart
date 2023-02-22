import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/components/button/large_green_button.dart';
import 'package:booqs_mobile/components/weakness/new_lap_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessNewLapButton extends ConsumerWidget {
  const WeaknessNewLapButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // そもそも弱点問題がない場合には、周回ボタンではなく、空であることを伝えるメッセージを表示する。
    final int? weaknessesCount =
        ref.watch(currentUserProvider.select((user) => user?.weaknessesCount));
    if (weaknessesCount == null || weaknessesCount == 0) {
      return const Text('苦手な問題はありません',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black54,
              height: 4));
    }

    const btnText = '周回する';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: InkWell(
        onTap: () {
          const screen = WeaknessNewLapScreen();
          Dialogs.slideFromBottomFade(screen);
        },
        child: const LargeGreenButton(label: btnText, icon: null),
      ),
    );
  }
}
