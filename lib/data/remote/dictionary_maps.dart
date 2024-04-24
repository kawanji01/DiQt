import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart' as http;

class RemoteDictionaryMaps {
  // My辞書を取得する
  static Future<Map?> myDictionaries() async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/dictionary_maps/my_dictionaries');

      final http.Response res = await HttpService.post(url, null);
      if (res.statusCode != 200) {
        FirebaseCrashlytics.instance
            .log('Server responded with status code: ${res.statusCode}');
        return null;
      }

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

  // 追加可能な辞書を表示する
  static Future<Map?> addition(int pageKey, int pageSize) async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/dictionary_maps/addition');

      final Map<String, dynamic> body = {'page': pageKey, 'size': pageSize};

      final http.Response res = await HttpService.post(url, body);

      if (res.statusCode != 200) {
        FirebaseCrashlytics.instance
            .log('Server responded with status code: ${res.statusCode}');
        return null;
      }

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

  // 辞書を追加する
  static Future<Map?> add(List<int> dictionaryIds) async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/dictionary_maps/add');

      final Map<String, dynamic> body = {
        'dictionary_ids': dictionaryIds.join(',')
      };
      final http.Response res = await HttpService.post(url, body);

      if (res.statusCode != 200) {
        // FirebaseCrashlytics.instance.log('Server responded with status code: ${res.statusCode}');
        return null;
      }

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

  // 削除可能な辞書を表示する
  static Future<Map?> removal() async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/dictionary_maps/removal');

      final http.Response res = await HttpService.post(url, null);

      if (res.statusCode != 200) {
        FirebaseCrashlytics.instance
            .log('Server responded with status code: ${res.statusCode}');
        return null;
      }

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

  // 辞書を削除する
  static Future<Map?> remove(List<int> dictionaryIds) async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/dictionary_maps/remove');

      final Map<String, dynamic> body = {
        'dictionary_ids': dictionaryIds.join(',')
      };
      final http.Response res = await HttpService.delete(url, body);

      if (res.statusCode != 200) {
        FirebaseCrashlytics.instance
            .log('Server responded with status code: ${res.statusCode}');
        return null;
      }

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

  // OCRで画像から文字を取得する
  static Future<Map> ocr(
      {required File image, required String langCode}) async {
    try {
      final url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/dictionary_maps/ocr');
      final Map<String, String> body = {'lang_code': langCode};
      final res = await HttpService.multipartRequest(
          url: url, image: image, body: body);
      return {'status': res.statusCode, 'message': 'Upload Icon'};
    } on TimeoutException catch (e, s) {
      return ErrorHandler.timeoutMap(e, s);
    } on SocketException catch (e, s) {
      return ErrorHandler.socketExceptionMap(e, s);
    } catch (e, s) {
      return ErrorHandler.exceptionMap(e, s);
    }
  }
}
