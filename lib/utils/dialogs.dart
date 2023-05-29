import 'package:booqs_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class Dialogs {
  static Future<bool> confirm(
    BuildContext context,
    String title,
    String message,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(message),
        actions: <Widget>[
          SimpleDialogOption(
            child: const Text('キャンセル'),
            onPressed: () => Navigator.pop(context, false),
          ),
          SimpleDialogOption(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    return result == true;
  }

  // 主に報酬表示に利用する、拡大するアニメーションのついた報酬モーダルの表示
  // utils/answer/answer_reward.dartで多用
  // staticではないのは、static は mockitoで mock できないため。
  Future<void> reward(Widget screen) async {
    await showAnimatedDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          // elevation: 0.0, // Set this to zero
          // ClipRRectを利用することで、画像が各丸からはみ出す問題を防ぐ。
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: screen,
          ),
        );
      },
      animationType: DialogTransitionType.scale,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 700),
    );
  }

  // 下からふわっと表示されるダイアログ
  static Future<void> slideFromBottomFade(Widget screen) async {
    await showAnimatedDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: screen,
        );
      },
      animationType: DialogTransitionType.slideFromBottomFade,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 700),
    );
  }

  // 下からふわっと表示されるダイアログ
  static Future<void> normal(Widget screen) async {
    await showAnimatedDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: screen,
        );
      },
      animationType: DialogTransitionType.none,
      duration: const Duration(milliseconds: 0),
    );
  }
}
