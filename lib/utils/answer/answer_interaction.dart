import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/widgets/quiz/answer_interaction.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AnswerInteraction {
  static void show(AnswerNotification notification, BuildContext context) {
    // アニメーションをアニメーション無しで即座に消す ref: https://kikuragechan.com/flutter/snackbar
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    MaterialColor color = Colors.red;
    if (notification.correct) {
      color = Colors.blue;
    }
    // SnackBarを表示する
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      // SnackBarの背景色
      backgroundColor: color,
      duration: const Duration(days: 1),
      content: QuizAnswerInteraction(
        notification: notification,
      ),
    ));
    // 紙吹雪を表示する。

    /* Fluttertoast.showToast(
        msg:
            "This is Center \n Short Toast aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
        webShowClose: true); */
  }
}
