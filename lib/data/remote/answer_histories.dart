import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart';

class RemoteAnswerHistories {
  // 解答履歴（総合）
  static Future<Map?> index(int pageKey, int pageSize) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/answer_histories?page=$pageKey&size=$pageSize');
      final Response res = await HttpService.get(url);
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

  // 今日間違えた問題
  static Future<Map?> todaysMistakes(int pageKey, int pageSize) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/answer_histories/todays_mistakes?page=$pageKey&size=$pageSize');
      final Response res = await HttpService.get(url);
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
