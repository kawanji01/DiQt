import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart';

class RemoteDictionaries {
  static Future<Map?> index() async {
    try {
      final Uri url = Uri.parse('${DiQtURL.root()}/api/v1/mobile/dictionaries');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;
      final Map<String, dynamic> resMap = json.decode(res.body);
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

  // 辞書情報
  static Future<Map> show(int dictionaryId) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/dictionaries/$dictionaryId');
      final Response res = await HttpService.get(url);

      if (ErrorHandler.isErrorResponse(res)) return ErrorHandler.errorMap(res);
      final Map<String, dynamic> resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      return ErrorHandler.timeoutMap(e, s);
    } on SocketException catch (e, s) {
      return ErrorHandler.socketExceptionMap(e, s);
    } catch (e, s) {
      return ErrorHandler.exceptionMap(e, s);
    }
  }

  // 項目の素早い検索
  // 単語・熟語の検索
  static Future<Map> search(
      {required int dictionaryId,
      required String keyword,
      required int pageKey,
      required int pageSize}) async {
    try {
      final Map<String, dynamic> body = {
        'keyword': keyword,
        'page': pageKey,
        'size': pageSize,
      };

      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/dictionaries/$dictionaryId/search');
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

  // 単語・熟語の検索
  static Future<Map?> wordSearch(
      int dictionaryId, String keyword, int pageKey, int pageSize) async {
    try {
      final Map<String, dynamic> body = {
        'keyword': keyword,
        'page': pageKey,
        'size': pageSize,
      };

      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/dictionaries/$dictionaryId/word_search');
      final Response res = await HttpService.post(
        url,
        body,
      );
      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 例文の検索
  static Future<Map?> sentenceSearch(
      int dictionaryId, String keyword, int pageKey, int pageSize) async {
    try {
      final Map<String, dynamic> body = {
        'keyword': keyword,
        'page': pageKey,
        'size': pageSize,
      };

      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/dictionaries/$dictionaryId/sentence_search');
      final Response res = await HttpService.post(
        url,
        body,
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

  // 文法タグの取得
  static Future<Map?> grammaticalTags(int dictionaryId) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/dictionaries/$dictionaryId/grammatical_tags');
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
}
