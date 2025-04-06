import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booqs_mobile/components/exp/level_up_screen.dart';
import 'package:flutter/material.dart';

class LevelUpDialog {
  static void show(BuildContext context, int totalExp) {
    AwesomeDialog(
      context: context,
      animType: AnimType.bottomSlide,
      dialogType: DialogType.noHeader,
      bodyHeaderDistance: 0,
      padding: const EdgeInsets.all(0),
      dialogBackgroundColor: Colors.white,
      body: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ExpLevelUpScreen(
          totalExp: totalExp,
        ),
      ),
    ).show();
  }
}
