import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';

class LanguageHandler {
  // 言語コードを取得
  static String getLangCode(int langNumber) {
    String? langCode = languageCodeMap.entries
        .firstWhere(
          (entry) => entry.value == langNumber,
          orElse: () => const MapEntry('undefined', 0),
        )
        .key;
    return langCode;
  }

  // 言語番号を取得
  static int getLangNumber(String langCode) {
    int? langNumber = languageCodeMap.entries
        .firstWhere(
          (entry) => entry.key == langCode,
          orElse: () => const MapEntry('undefined', 0),
        )
        .value;
    return langNumber;
  }

  // 言語名を取得
  static String getLanguageFromNumber(int number) {
    String langCode = getLangCode(number);
    if (langCode == 'undefined') return 'undefined';
    // 詳しくはi18n/en/langの　Icelandic　を参照。
    if (langCode == 'is') {
      langCode = 'Icelandic';
    }
    // slangだと-が利用できないので。
    langCode = langCode.replaceAll('-', '_');
    final String? language = t['lang.$langCode'];
    return language ?? 'undefined';
  }
}
