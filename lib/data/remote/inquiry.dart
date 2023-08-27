import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/utils/device_info_service.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/http_service.dart';

import 'package:http/http.dart';

class RemoteInquiries {
  // お問い合わせ
  static Future<Map> create(String contenct) async {
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
      if (ErrorHandler.isErrorResponse(res)) return ErrorHandler.errorMap(res);

      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      return ErrorHandler.timeoutMap(e, s);
    } on SocketException catch (e, s) {
      return ErrorHandler.socketExceptionMap(e, s);
    } catch (e, s) {
      return ErrorHandler.exceptionMap(e, s);
    }
  }
}
