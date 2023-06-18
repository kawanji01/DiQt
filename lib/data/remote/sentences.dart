import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart';

class RemoteSentences {
  // 例文の読み込み
  static Future<Map?> show(int sentenceId) async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/sentences/$sentenceId');
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

  //
  static Future<Map?> newSentence(int dictionaryId) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/sentences/new?dictionary_id=$dictionaryId');
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

  //
  static Future<Map?> edit(int sentenceId) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/sentences/$sentenceId/edit');
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

  // 例文の作成
  static Future<Map?> create(Map<String, dynamic> params) async {
    try {
      final Map<String, dynamic> body = {'sentence': params};

      final Uri url = Uri.parse('${DiQtURL.root()}/api/v1/mobile/sentences');
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

  // 例文の更新
  static Future<Map?> update(Map<String, dynamic> params) async {
    try {
      final Map<String, dynamic> body = {'sentence': params};

      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/sentences/${params['id']}');
      final Response res = await HttpService.patch(
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

  // 例文の削除
  static Future<Map?> destroy(int sentenceId) async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/sentences/$sentenceId');
      final Response res = await HttpService.delete(url, null);
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

  // 例文検索
  static Future<Map?> search(
      String keyword, int dictionaryId, int pageKey, int pageSize) async {
    try {
      final Map<String, dynamic> body = {
        'keyword': keyword,
        'dictionary_id': '$dictionaryId',
        'page': pageKey,
        'size': pageSize
      };

      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/sentences/search');
      // 検索条件が長い場合に、getだとURLの文字数制限に引っかかる可能性があるのでpostを使う。
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

  // AIによる例文の生成
  static Future<Map?> generate(
      String keyword,
      int dictionaryId,
      String posTagId,
      String meaning,
      String sentenceType,
      String difficulty,
      String model,
      String temperature) async {
    try {
      final Map<String, dynamic> body = {
        'keyword': keyword,
        'pos_tag_id': posTagId,
        'meaning': meaning,
        'sentence_type': sentenceType,
        'difficulty': difficulty,
        'model': model,
        'dictionary_id': '$dictionaryId',
        'temperature': temperature,
      };

      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/sentences/generate');
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
}
