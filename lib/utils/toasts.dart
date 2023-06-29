import 'package:booqs_mobile/main.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class Toasts {
  static Future<void> showBlack(Widget child) async {
    showFlash(
      context: navigatorKey.currentContext!,
      duration: const Duration(seconds: 1),
      builder: (dialogContext, controller) {
        // ref: https://resocoder.com/2021/01/30/snackbar-toast-dialog-in-flutter-flash-package/
        // ref: https://itnext.io/highly-customizable-toast-dialog-snackbar-in-flutter-2c27e533dd63
        return FlashBar(
          controller: controller,
          position: FlashPosition.top,
          backgroundColor: Colors.black87,
          content: child,
        );
      },
    );
  }

  static Future<void> reviewSetting(String text) async {
    Toasts.showBlack(
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.alarm,
            color: Colors.white,
            size: 18.0,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  static Future<void> showSimple(BuildContext context, String text) async {
    final richText = RichText(
      text: TextSpan(
        text: ' $text',
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
    Toasts.showBlack(richText);
  }
}
