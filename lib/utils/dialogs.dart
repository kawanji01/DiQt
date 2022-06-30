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

  // 拡大するアニメーションのついた報酬モーダルの表示
  static Future<void> reward(Widget screen) async {
    await showAnimatedDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomDialog(
          child: screen,
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

  // 下からふわっと表示されるダイアログ
  static Future<void> slideFromBottomFade(Widget screen) async {
    await showAnimatedDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomDialog(
          child: screen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
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
          child: screen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
      animationType: DialogTransitionType.none,
      duration: const Duration(milliseconds: 0),
    );
  }
}
