import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart';

class RemoteCheers {
  // 応援の作成
  static Future<Map?> create(int activityId) async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/cheers');

      final Map<String, dynamic> body = {
        'activity_id': '$activityId',
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
