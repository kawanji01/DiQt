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
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          SimpleDialogOption(
            child: const Text('Cancel'),
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
