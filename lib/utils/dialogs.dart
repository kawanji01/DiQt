import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/main.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static Future<bool> confirm({
    required BuildContext context,
    required String title,
    required String message,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        content: Text(message),
        actions: <Widget>[
          SimpleDialogOption(
            child: Text(t.shared.cancel,
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            onPressed: () => Navigator.pop(context, false),
          ),
          SimpleDialogOption(
            child: Text(
              t.shared.ok,
              style: const TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
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
  // barrierDismissibleがfalseでも画面外のタップでダイアログを閉じられないので注意。それがしたいならstaticメソッドのダイアログを利用する。
  Future<void> reward(Widget screen) async {
    await AwesomeDialog(
      context: navigatorKey.currentContext!,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: Colors.white,
      bodyHeaderDistance: 0,
      padding: const EdgeInsets.all(0),
      body: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: screen,
      ),
    ).show();
  }

  // 下からふわっと表示されるダイアログ
  static Future<void> slideFromBottomFade(Widget screen) async {
    await AwesomeDialog(
      context: navigatorKey.currentContext!,
      animType: AnimType.bottomSlide,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: Colors.white,
      bodyHeaderDistance: 0,
      padding: const EdgeInsets.all(0),
      body: screen,
    ).show();
  }

  // 下からふわっと表示されるダイアログ
  static Future<void> normal(Widget screen) async {
    await AwesomeDialog(
      context: navigatorKey.currentContext!,
      animType: AnimType.bottomSlide,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: Colors.white,
      bodyHeaderDistance: 0,
      padding: const EdgeInsets.all(0),
      body: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: screen,
      ),
    ).show();
  }
}
