import 'package:booqs_mobile/utils/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 書き換えが気になるなどでRiverpodを利用しない場合に利用するユーザー情報
class LocalUserInfo {
  // ユーザーの認証情報を取得する
  static Future<String?> authToken() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    return token;
  }

  // ユーザーのlocaleを取得する
  static Future<String> locale() async {
    const storage = FlutterSecureStorage();
    final String? userLocale = await storage.read(key: 'locale');
    String locale;
    if (userLocale != null && LanguageService.langCodeSupported(userLocale)) {
      locale = userLocale;
    } else {
      // ローカルストレージにユーザーの有効なlocaleがなければデバイスのlocaleを利用する。
      locale = WidgetsBinding.instance.window.locale.toLanguageTag();
    }
    return locale;
  }

  // ユーザーのIDを取得する
  static Future<String?> publicUid() async {
    const storage = FlutterSecureStorage();
    String? uid = await storage.read(key: 'publicUid');
    return uid;
  }
}
