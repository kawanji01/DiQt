import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart';

class RemoteReviews {
  // 復習問題一覧
  static Future<Map?> index(String? order) async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/reviews?order=$order');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 予定
  static Future<Map?> scheduled(int pageKey, int pageSize, String order) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/reviews/scheduled?order=$order&page=$pageKey&size=$pageSize');
      final Response res = await HttpService.get(url);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // すべて
  static Future<Map?> all(int pageKey, int pageSize, String order) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/reviews/all?order=$order&page=$pageKey&size=$pageSize');
      final Response res = await HttpService.get(url);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 復習設定の新規作成
  static Future<Map> create({required int quizId}) async {
    try {
      final Uri url = Uri.parse('${DiQtURL.root()}/api/v1/mobile/reviews');
      final Map<String, dynamic> body = {
        'quiz_id': '$quizId',
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

  // 復習設定の更新
  static Future<Map> update(int reviewId, int intervalSetting) async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/reviews/$reviewId');
      final Map<String, dynamic> body = {
        'interval_setting': '$intervalSetting'
      };

      final Response res = await HttpService.patch(url, body);
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

  // 復習設定の削除
  static Future<Map> destroy(int reviewId) async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/reviews/$reviewId');

      final Response res = await HttpService.delete(url, null);
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

  // 復習の全削除
  static Future<Map?> destroyAll() async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/reviews/destroy_all');

      final Response res = await HttpService.delete(url, null);
      if (res.statusCode != 200) return null;

      Map resMap = json.decode(res.body);
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

  static Future<Map?> destroyInvalidItems() async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/reviews/destroy_invalid_items');

      final Response res = await HttpService.delete(url, null);
      if (ErrorHandler.isErrorResponse(res)) return ErrorHandler.errorMap(res);

      Map resMap = json.decode(res.body);
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
