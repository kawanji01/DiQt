import 'package:booqs_mobile/utils/locale_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Providerが消えても保存しておきたいユーザー情報
// Providerの設定は再起動（Restart）などすると消えるので、authTokenやlocaleなど半永続的に持ちたいデータはLocalStoregeに保存しておく。
class LocalUserInfo {
  // ユーザーの認証情報を取得する
  // Providerが消えてもログインを維持できるように、認証トークンはSecureStorageに保存しておく。
  static Future<String?> authToken() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    return token;
  }

  // ユーザーの認証情報を書き込む
  static Future<void> writeAuthToken(String? token) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'token', value: '$token');
  }

  // ユーザーのlocaleを取得する
  // Provider が消えても locale設定を維持するために、localeはSecureStoreageに保存しておく。
  static Future<String> locale() async {
    const storage = FlutterSecureStorage();
    final String? userLocale = await storage.read(key: 'locale');
    String locale;
    if (userLocale != null && LocaleHandler.langCodeSupported(userLocale)) {
      locale = userLocale;
    } else {
      // ローカルストレージにユーザーの有効なlocaleがなければデバイスのlocaleを利用する。
      locale = WidgetsBinding.instance.window.locale.toLanguageTag();
    }
    return locale;
  }

  // ユーザーのlocaleを取得する
  static Future<String> writeLocale(String langCode) async {
    final String locale = LocaleHandler.getLocaleByLangCode(langCode);
    const storage = FlutterSecureStorage();
    await storage.write(key: 'locale', value: locale);
    return locale;
  }

  // ホーム画面で選択した辞書IDを取得する
  // Providerが消えても選択した辞書情報を維持できるように、選択した辞書のIDはSecureStorageに保存しておく。
  static Future<String?> selectedDictionaryId() async {
    const storage = FlutterSecureStorage();
    String? dictionaryId = await storage.read(key: 'selectedDictionaryId');
    return dictionaryId;
  }

  // ホーム画面で選択した辞書IDを保存する
  static void writeSelectedDictionaryId(int dictionaryId) {
    const storage = FlutterSecureStorage();
    storage.write(key: 'selectedDictionaryId', value: '$dictionaryId');
  }
}
