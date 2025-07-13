import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/utils/crashlytics_service.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart';
import 'package:booqs_mobile/utils/sentry_service.dart';

class RemoteAchievementMaps {
  static Future<Map?> update(int achievementMapId) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/achievement_maps/$achievementMapId');
      final Response res = await HttpService.patch(url, null);
      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      CrashlyticsService.recordError(e, s);
      await SentryService.captureException(e, stackTrace: s);
      return null;
    } on SocketException catch (e, s) {
      CrashlyticsService.recordError(e, s);
      await SentryService.captureException(e, stackTrace: s);
      return null;
    } catch (e, s) {
      CrashlyticsService.recordError(e, s);
      await SentryService.captureException(e, stackTrace: s);
      return null;
    }
  }
}
