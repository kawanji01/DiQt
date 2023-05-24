import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart';

class RemoteDrills {
  // 未解答の問題を取得する
  static Future<Map?> unsolved(String publicUid, String order) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/drills/$publicUid/unsolved?token=$token&order=$order');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;
      Map<String, dynamic> resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 解答済の問題
  static Future<Map?> solved(
      String publicUid, int pageKey, int pageSize, String order) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/drills/$publicUid/solved?order=$order&page=$pageKey&size=$pageSize&token=$token');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;
      final Map<String, dynamic> resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // すべての問題
  static Future<Map?> show(
      String publicUid, int pageKey, int pageSize, String order) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/drills/$publicUid?order=$order&page=$pageKey&size=$pageSize&token=$token');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;
      final Map<String, dynamic> resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 新しい周回を始める
  static Future<Map?> newLap(String publicUid) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/drills/$publicUid/new_lap');
      final String encodedData = json.encode({
        'token': token,
      });
      final Response res = await HttpService.post(url, encodedData);
      if (res.statusCode != 200) return null;
      final Map<String, dynamic> resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }
}
