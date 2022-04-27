import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class RemoteUsers {
  // ログインユーザーの取得　　　users/status
  // （次のアップデートで削除予定）
  /* static Future<Map?> status(BuildContext context) async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    if (token == null) return null;

    Uri url = Uri.parse('${DiQtURL.root(context)}/api/v1/mobile/users/status');
    Response res = await post(url, body: {'token': token});

    if (res.statusCode != 200) return null;
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map resMap = json.decode(res.body);
    return resMap;
  } */

  // 現在のログインユーザーの取得　　　users/current_user
  static Future<Map?> currentUser() async {
    const storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');

    if (token == null) return null;

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/current?token=$token');
    final Response res = await get(url);

    if (res.statusCode != 200) return null;
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    final Map resMap = json.decode(res.body);
    return resMap;
  }

  // 特定のユーザー情報を取得
  static Future<Map?> show(String publicUid) async {
    final String token = await LocalUserInfo.authToken() ?? '';
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/$publicUid?token=$token');
    final Response res = await get(url);

    if (res.statusCode != 200) return null;
    final Map resMap = json.decode(res.body);
    return resMap;
  }

  // 解答中の問題集の取得
  static Future<Map?> drillsInProgress() async {
    const storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');

    if (token == null) return null;

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/drills_in_progress?token=$token');
    final Response res = await get(url);

    if (res.statusCode != 200) return null;
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    final Map resMap = json.decode(res.body);
    return resMap;
  }

  // 実績メダルの取得
  static Future<Map?> achievements(BuildContext context) async {
    const storage = FlutterSecureStorage();
    String? uid = await storage.read(key: 'publicUid');
    if (uid == null) return null;

    Uri url = Uri.parse(
        '${DiQtURL.root(context)}/api/v1/mobile/users/$uid/achievements');
    Response res =
        await get(url, headers: {"Content-Type": "application/json"});

    if (res.statusCode != 200) {
      return null;
    }
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map resMap = json.decode(res.body);
    return resMap;
  }

  // 退会
  static Future<Map?> withdrawal(BuildContext context) async {
    const storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');
    String? uid = await storage.read(key: 'publicUid');

    if (token == null || uid == null) return null;

    Uri url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/users/$uid?token=$token');
    Response res = await delete(url);

    if (res.statusCode != 200) return null;

    Map resMap = json.decode(res.body);
    return resMap;
  }
}
