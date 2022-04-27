import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class RemoteNotifications {
  // 通知の取得（削除予定）
  static Future<Map?> list(BuildContext context) async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    if (token == null) return null;

    final Uri url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/notifications/list');
    final Response res = await post(url, body: {'token': token});

    if (res.statusCode != 200) return null;

    Map resMap = json.decode(res.body);
    return resMap;
  }

  // 無限スクロールの通知
  static Future<Map?> index(int pageKey, int pageSize) async {
    String? token = await LocalUserInfo.authToken();
    if (token == null) return null;

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/notifications?page=$pageKey&size=$pageSize&token=$token');
    final Response res = await get(url);
    if (res.statusCode != 200) return null;

    final Map resMap = json.decode(res.body);
    return resMap;
  }
}
