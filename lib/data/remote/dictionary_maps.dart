import 'dart:async';
import 'dart:convert';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart' as http;

class RemoteDictionaryMaps {
  // My辞書を取得する
  static Future<Map?> myDictionaries() async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionary_maps/my_dictionaries');
      final String? token = await LocalUserInfo.authToken();
      final String encodedData = json.encode({'token': '$token'});

      final http.Response res = await HttpService.post(url, encodedData);
      if (res.statusCode != 200) {
        // FirebaseCrashlytics.instance.log('Server responded with status code: ${res.statusCode}');
        return null;
      }

      final Map? resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException {
      // FirebaseCrashlytics.instance.recordError(e);
      return null;
    } catch (e) {
      // FirebaseCrashlytics.instance.recordError(e);
      return null;
    }
  }

  // 追加可能な辞書を表示する
  static Future<Map?> addition(int pageKey, int pageSize) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionary_maps/addition');
      final String? token = await LocalUserInfo.authToken();
      final String encodedData =
          json.encode({'page': pageKey, 'size': pageSize, 'token': '$token'});
      final http.Response res = await HttpService.post(url, encodedData);

      if (res.statusCode != 200) {
        // FirebaseCrashlytics.instance.log('Server responded with status code: ${res.statusCode}');
        return null;
      }

      final Map? resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e) {
      // FirebaseCrashlytics.instance.recordError(e);
      return null;
    } catch (e) {
      // FirebaseCrashlytics.instance.recordError(e);
      return null;
    }
  }

  // 辞書を追加する
  static Future<Map?> add(List<int> dictionaryIds) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionary_maps/add');
      final String? token = await LocalUserInfo.authToken();
      final String encodedData = json.encode(
          {'dictionary_ids': dictionaryIds.join(','), 'token': '$token'});
      final http.Response res = await HttpService.post(url, encodedData);

      if (res.statusCode != 200) {
        // FirebaseCrashlytics.instance.log('Server responded with status code: ${res.statusCode}');
        return null;
      }

      final Map? resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e) {
      // FirebaseCrashlytics.instance.recordError(e);
      return null;
    } catch (e) {
      // FirebaseCrashlytics.instance.recordError(e);
      return null;
    }
  }

  // 削除可能な辞書を表示する
  static Future<Map?> removal() async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionary_maps/removal');
      final String? token = await LocalUserInfo.authToken();
      final String encodedData = json.encode({'token': '$token'});
      final http.Response res = await HttpService.post(url, encodedData);

      if (res.statusCode != 200) {
        // FirebaseCrashlytics.instance.log('Server responded with status code: ${res.statusCode}');
        return null;
      }

      final Map? resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e) {
      // FirebaseCrashlytics.instance.recordError(e);
      return null;
    } catch (e) {
      // FirebaseCrashlytics.instance.recordError(e);
      return null;
    }
  }

  // 辞書を削除する
  static Future<Map?> remove(List<int> dictionaryIds) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionary_maps/remove');
      final String? token = await LocalUserInfo.authToken();
      final String encodedData = json.encode(
          {'dictionary_ids': dictionaryIds.join(','), 'token': '$token'});
      final http.Response res = await HttpService.delete(url, encodedData);

      if (res.statusCode != 200) {
        // FirebaseCrashlytics.instance.log('Server responded with status code: ${res.statusCode}');
        return null;
      }

      final Map? resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e) {
      // FirebaseCrashlytics.instance.recordError(e);
      return null;
    } catch (e) {
      // FirebaseCrashlytics.instance.recordError(e);
      return null;
    }
  }
}
