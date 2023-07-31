import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart';

class RemoteWords {
  // 取得
  static Future<Map?> show(int wordId) async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/words/$wordId');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
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

  static Future<Map?> newWord(int dictionaryId, String keyword) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/words/new?dictionary_id=$dictionaryId&keyword=$keyword');
      final Response res = await HttpService.get(
        url,
      );

      if (res.statusCode != 200) return null;
      final Map? resMap = json.decode(res.body);
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

  // 編集
  static Future<Map?> edit(int wordId) async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/words/$wordId/edit');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
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

  // 新規作成
  static Future<Map> create(
      {required Map<String, dynamic> params, required String comment}) async {
    try {
      final Map<String, dynamic> body = {'word': params, 'comment': comment};
      final Uri url = Uri.parse('${DiQtURL.root()}/api/v1/mobile/words');
      final Response res = await HttpService.post(
        url,
        body,
      );
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

  // 更新
  static Future<Map> update(
      {required Map<String, dynamic> params, required String comment}) async {
    try {
      final Map<String, dynamic> body = {'word': params, 'comment': comment};

      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/words/${params['id']}');
      final Response res = await HttpService.patch(
        url,
        body,
      );
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

  // 削除
  static Future<Map> destroy(
      {required int wordId, required String comment}) async {
    try {
      final Map<String, dynamic> body = {'comment': comment};
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/words/$wordId');

      final Response res = await HttpService.delete(url, body);

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

  //
  static Future<Map?> search(int dictionaryId, String? keyword) async {
    try {
      if (keyword == null) return null;
      final Uri url = Uri.parse('${DiQtURL.root()}/api/v1/mobile/words/search');
      final Map<String, dynamic> body = {
        'dictionary_id': '$dictionaryId',
        'keyword': keyword,
      };
      final Response res = await HttpService.post(url, body);
      if (res.statusCode != 200) return null;
      // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
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

  // 自動補完 GET
  static Future<Map> autocomplete(int dictionaryId, String query) async {
    try {
      // 次のアップデートでwords/に戻す。
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/dictionaries/$dictionaryId/autocomplete?query=$query');

      final Response res = await HttpService.get(url);
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

  static Future<Map> generateMeaning(
      {required String keyword,
      required String posTagId,
      required String model,
      required int dictionaryId}) async {
    try {
      final Map<String, dynamic> body = {
        'keyword': keyword,
        'pos_tag_id': posTagId,
        'model': model,
        'dictionary_id': '$dictionaryId',
      };

      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/words/generate_meaning');
      final Response res = await HttpService.post(
        url,
        body,
      );
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
