import 'package:flutter/material.dart';

// DiQt の API の URL を生成する
class DiQtURL {
  static String root(BuildContext context) {
    return "${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}";
  }

  //
  static String rootWithLocale(String locale) {
    return '${const String.fromEnvironment("ROOT_URL")}/$locale';
  }

  //
  static String rootWithoutLocale() {
    return const String.fromEnvironment("ROOT_URL");
  }
}
