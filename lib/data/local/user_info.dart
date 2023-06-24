import 'package:booqs_mobile/utils/locale_handler.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Providerが消えても保存しておきたいユーザー情報
// Providerの設定は再起動（Restart）などすると消えるので、authTokenやlocaleなど半永続的に持ちたいデータはLocalStoregeに保存しておく。
class LocalUserInfo {
  // ユーザーのlocaleを取得する
  // Provider が消えても locale設定を維持するために、localeはSecureStoreageに保存しておく。
  static Future<String> locale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? locale = prefs.getString('locale');
    if (locale != null && LocaleHandler.langCodeSupported(locale)) {
      return locale;
    } else {
      // ローカルストレージにユーザーの有効なlocaleがなければデバイスのlocaleを利用する。
      return WidgetsBinding.instance.window.locale.toLanguageTag();
    }
  }

  // APIのURLに含められるlocaleを取得する。
  // つまり。languageCode-countryCode（ja-ja）ではなく、languageCodeのみ（ja）
  static Future<String> localeForAPI() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? locale = prefs.getString('locale');
    // storageのlocaleがAPIの対応しているlocaleな場合
    if (locale != null && LocaleHandler.langCodeSupported(locale)) {
      return locale;
    }
    return LocaleHandler.localeForAPIByCode(locale);
  }

  // ユーザーのlocaleを取得する
  static Future<String> writeLocale(String langCode) async {
    final String locale = LocaleHandler.localeByCode(langCode);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale);
    return locale;
  }

  // ホーム画面で選択した辞書IDを取得する
  // Providerが消えても選択した辞書情報を維持できるように、選択した辞書のIDは Storage に保存しておく。
  static Future<int?> selectedDictionaryId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? dictionaryId = prefs.getInt('selectedDictionaryId');
    return dictionaryId;
  }

  // ホーム画面で選択した辞書IDを保存する
  static Future<void> writeSelectedDictionaryId(int dictionaryId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedDictionaryId', dictionaryId);
  }
}
