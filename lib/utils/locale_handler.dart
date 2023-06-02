import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/utils/language_handler.dart';
import 'package:flutter/material.dart';

// Locale関連の便利メソッド
class LocaleHandler {
  // 言語コードからlocale情報を取得する。
  static String localeByCode(String? langCode) {
    if (langCodeSupported(langCode)) {
      return langCode!;
    }
    return WidgetsBinding.instance.window.locale.toLanguageTag();
  }

  // 言語コードから「API」用のlocale情報を取得する。
  // MEMO: getLocaleByLangCode　では、languageCode-countryCode（例：ja-ja）を返すことがあるが、
  // APIのURLでは languageCode（例：ja） しか設定できない。
  static String localeForAPIByCode(String? langCode) {
    if (langCodeSupported(langCode)) {
      return langCode!;
    }
    // 引数の langCode にAPIが対応していないならデバイスのlangCodeを検討する
    final String deviceLangCode =
        WidgetsBinding.instance.window.locale.languageCode;
    if (langCodeSupported(deviceLangCode)) {
      return deviceLangCode;
    }
    // デバイスのlangCodeにもAPIが対応していないなら、アプリのデフォルトのlangCodeを利用する。
    return defaultLangCode;
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
