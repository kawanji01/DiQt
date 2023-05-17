import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LanguageService {
  // localeを設定する
  static Future<String> setLocale(User? user) async {
    String locale;
    if (user == null) {
      locale = await LocalUserInfo.locale();
    } else {
      // localeをlocaleStorageに保存して、再取得する
      const storage = FlutterSecureStorage();
      await storage.write(key: 'locale', value: user.locale());
      locale = await LocalUserInfo.locale();
    }
    // 全体のlocaleを設定する。
    LocaleSettings.setLocaleRaw(locale);
    // timeagoのlocaleを設定する。
    DateTimeFormatter.setLocale(locale);
    return locale;
  }

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

  // 対応言語かどうかを検証する
  static bool langNumberSupported(int langNumber) {
    return supportedLangNumbers.contains(langNumber);
  }

  static bool langCodeSupported(String langCode) {
    final langNumber = getLangNumber(langCode);
    return langNumberSupported(langNumber);
  }
}
