import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/components/button/large_green_button.dart';
import 'package:booqs_mobile/components/weakness/new_lap_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeaknessNewLapButton extends ConsumerWidget {
  const WeaknessNewLapButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // そもそも弱点問題がない場合には、周回ボタンではなく、空であることを伝えるメッセージを表示する。
    final int? weaknessesCount =
        ref.watch(currentUserProvider.select((user) => user?.weaknessesCount));
    if (weaknessesCount == null || weaknessesCount == 0) {
      return Text(t.shared.no_name_found(name: t.weaknesses.weakness),
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black54,
              height: 4));
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: InkWell(
        onTap: () {
          const screen = WeaknessNewLapScreen();
          Dialogs.slideFromBottomFade(screen);
        },
        child: LargeGreenButton(label: t.weaknesses.new_lap, icon: null),
      ),
    );
  }
}
