import 'dart:convert';

import 'package:booqs_mobile/utils/device_info%20_service.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class RemoteInquiries {
  // お問い合わせ
  static Future<Map?> create(String contenct) async {
    try {
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: 'token');
      if (token == null) return null;

      final deviceInfo = DeviceInfoService();
      final String platform = deviceInfo.getPlatform();
      final String deviceName = await deviceInfo.getName();

      final Uri url =
          Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/inquiries');
      final String encodedData = json.encode({
        'token': token,
        'content': contenct,
        'platform': platform,
        'device_name': deviceName,
      });
      final Response res = await HttpService.post(url, encodedData);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }
}
