import 'package:flutter/material.dart';

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
}
