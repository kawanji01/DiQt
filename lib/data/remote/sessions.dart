import 'dart:convert';

import 'package:booqs_mobile/services/device_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class RemoteSessions {
  // ログアウト / sessions/logout
  static Future<Map?> logout(BuildContext context) async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    final deviceInfo = DeviceInfoService();
    final String deviceIdentifier = await deviceInfo.getIndentifier();
    var url =
        Uri.parse('${DiQtURL.root(context)}/api/v1/mobile/sessions/logout');
    Response res = await post(url,
        body: {'token': '$token', 'device_identifier': deviceIdentifier});
    Map resMap = json.decode(res.body);
    return resMap;
  }
}
