import 'package:flutter/material.dart';

// DiQtのAPIのURLを生成する
class DiQtURL {
  static String root(BuildContext context) {
    return "${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}";
  }
}
