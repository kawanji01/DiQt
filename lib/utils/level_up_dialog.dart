import 'package:booqs_mobile/widgets/exp/level_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class LevelUpDialog {
  static void show(BuildContext context, int totalExp) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomDialog(
          child: ExpLevelUpScreen(
            totalExp: totalExp,
          ),
          // ref: https://medium.flutterdevs.com/custom-dialog-in-flutter-7ca5c2a8d33a
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
      animationType: DialogTransitionType.scale,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 700),
    );
  }
}
