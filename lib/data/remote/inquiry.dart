import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/utils/device_info_service.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:http/http.dart';

class RemoteInquiries {
  // お問い合わせ
  static Future<Map?> create(String contenct) async {
    try {
      final deviceInfo = DeviceInfoService();
      final String platform = deviceInfo.getPlatform();
      final String deviceName = await deviceInfo.getName();

      final Uri url = Uri.parse('${DiQtURL.root()}/api/v1/mobile/inquiries');
      final Map<String, dynamic> body = {
        'content': contenct,
        'platform': platform,
        'device_name': deviceName,
      };
      final Response res = await HttpService.post(url, body);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } on SocketException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }
}
