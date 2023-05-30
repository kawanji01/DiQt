import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/language_handler.dart';
import 'package:flutter/material.dart';

// Locale関連の便利メソッド
class LocaleHandler {
  // ユーザー情報からlocale情報を取得する。
  static String getLocaleByUser(User? user) {
    if (user == null) {
      // デバイスのデフォルトのlocale
      return WidgetsBinding.instance.window.locale.toLanguageTag();
    }
    return getLocaleByLangCode(user.langCode());
  }

  // 言語コードからlocale情報を取得する。
  static String getLocaleByLangCode(String? langCode) {
    if (langCode == null) {
      return WidgetsBinding.instance.window.locale.toLanguageTag();
    }
    if (langCodeSupported(langCode)) {
      return langCode;
    }
    return WidgetsBinding.instance.window.locale.toLanguageTag();
  }

  // 言語IDが対応言語か検証する
  static bool langNumberSupported(int? langNumber) {
    if (langNumber == null) {
      return false;
    }
    return supportedLangNumbers.contains(langNumber);
  }

  // 言語コードが対応言語か検証する
  static bool langCodeSupported(String? langCode) {
    if (langCode == null) {
      return false;
    }
    final langNumber = LanguageHandler.getLangNumber(langCode);
    return langNumberSupported(langNumber);
  }
}
