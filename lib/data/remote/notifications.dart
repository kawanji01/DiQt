import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class RemoteNotifications {
  // 通知の取得　　　users/:id/status
  static Future<Map?> index(BuildContext context) async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    if (token == null) return null;

    Uri url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/notifications/list');
    Response res = await post(url, body: {'token': token});

    if (res.statusCode != 200) return null;

    Map resMap = json.decode(res.body);
    return resMap;
  }
}
