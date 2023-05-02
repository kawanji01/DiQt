import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';

class LanguageService {
  // 言語コードを取得
  static String getLangCode(int number) {
    String? langCode;
    languageCodeMap.forEach((String key, int value) {
      if (value == number) {
        langCode = key;
      }
    });
    return langCode ?? 'undefined';
  }

  // 言語番号を取得
  static int getLangNumber(String code) {
    int? langNumber;
    languageCodeMap.forEach((String key, int value) {
      if (key == code) {
        langNumber = value;
      }
    });
    return langNumber ?? 0;
  }

  // 言語名を取得
  static String getLanguageFromNumber(int number) {
    String langCode = getLangCode(number);
    if (langCode == 'undefined') return 'undefined';
    // 詳しくはi18n/en/langの　Icelandic　を参照。
    if (langCode == 'is') {
      langCode = 'Icelandic';
    }
    langCode = langCode.replaceAll('-', '_');
    final String? language = t['lang.$langCode'];
    return language ?? 'undefined';
  }
}
