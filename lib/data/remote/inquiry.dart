import 'dart:convert';

import 'package:booqs_mobile/utils/device_info%20_service.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class RemoteInquiries {
  // お問い合わせ
  static Future<Map?> create(String contenct) async {
    const storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');
    if (token == null) return null;

    final deviceInfo = DeviceInfoService();
    final String platform = deviceInfo.getPlatform();
    final String deviceName = await deviceInfo.getName();

    final Uri url =
        Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/inquiries');
    final Map boby = {
      'token': token,
      'content': contenct,
      'platform': platform,
      'device_name': deviceName,
    };
    final Response res = await post(url, body: boby);
    if (res.statusCode != 200) return null;

    final Map resMap = json.decode(res.body);
    return resMap;
  }
}
