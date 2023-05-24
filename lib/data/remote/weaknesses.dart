import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart';

class RemoteWeaknesses {
  // すべての苦手な問題を取得する
  static Future<Map?> index(int pageKey, int pageSize, String order) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/weaknesses?order=$order&page=$pageKey&size=$pageSize&token=$token');
      final Response res = await HttpService.get(url);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 移行用あとでunsolvedに書き換え
  static Future<Map?> list(String order) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/weaknesses/list?order=$order&token=$token');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 未解答の弱点を取得する
  static Future<Map?> unsolved(String order) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/weaknesses/unsolved?order=$order&token=$token');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> solved(int pageKey, int pageSize, String order) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/weaknesses/solved?order=$order&page=$pageKey&size=$pageSize&token=$token');
      final Response res = await HttpService.get(url);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 苦手な問題に追加
  static Future<Map?> create(int quizId) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final String encodedData =
          json.encode({'token': token, 'quiz_id': quizId});

      final Uri url =
          Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/weaknesses');
      final Response res = await HttpService.post(url, encodedData);

      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 苦手な問題から削除する
  static Future<Map?> destroy(int weaknessId) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final String encodedData = json.encode({'token': token});
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/weaknesses/$weaknessId');
      final Response res = await HttpService.delete(url, encodedData);

      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 苦手な問題をすべて未解答に戻す
  static Future<Map?> newLap() async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final String encodedData = json.encode({'token': token});

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/weaknesses/new_lap');
      final Response res = await HttpService.patch(url, encodedData);

      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }
}
