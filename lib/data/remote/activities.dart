import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/utils/crashlytics_service.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart';

class RemoteActivities {
  static Future<Map?> index(int pageKey, int pageSize, String order) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/activities/list?order=$order&page=$pageKey&size=$pageSize');
      final Response res = await HttpService.get(url);
      if (res.statusCode != 200) return null;
      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      CrashlyticsService.reccordError(e, s);
      return null;
    } on SocketException catch (e, s) {
      CrashlyticsService.reccordError(e, s);
      return null;
    } catch (e, s) {
      CrashlyticsService.reccordError(e, s);
      return null;
    }
  }
}
