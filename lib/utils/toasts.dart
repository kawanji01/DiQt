import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class Toasts {
  static Future<void> showBlack(BuildContext context, Widget child) async {
    showFlash(
      context: context,
      duration: const Duration(seconds: 3),
      builder: (context, controller) {
        // ref: https://resocoder.com/2021/01/30/snackbar-toast-dialog-in-flutter-flash-package/
        // ref: https://itnext.io/highly-customizable-toast-dialog-snackbar-in-flutter-2c27e533dd63
        return Flash(
          controller: controller,
          barrierDismissible: false,
          alignment: Alignment.topCenter,
          borderRadius: BorderRadius.circular(12),
          backgroundColor: Colors.black87,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: child,
          ),
        );
      },
    );
  }

  static Future<void> reviewSetting(BuildContext context, String text) async {
    final richText = RichText(
        text: TextSpan(children: [
      const WidgetSpan(
        child: Icon(
          Icons.alarm,
          color: Colors.white,
          size: 18.0,
        ),
      ),
      TextSpan(
          text: ' $text',
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))
    ]));
    await Toasts.showBlack(context, richText);
  }
}
