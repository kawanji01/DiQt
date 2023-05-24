import 'dart:convert';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart';

class RemoteChapters {
  static Future<Map?> index() async {
    try {
      final String? token = await LocalUserInfo.authToken();
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/chapters?token=$token');
      final Response res = await HttpService.get(url);
      // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
      final Map<String, dynamic> resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> show(String publicUid) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/chapters/$publicUid?token=$token');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;
      final Map<String, dynamic> resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> activities(
      String publicUid, int pageKey, int pageSize) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/chapters/$publicUid/activities?page=$pageKey&size=$pageSize&token=$token');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;
      final Map<String, dynamic> resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> ranking(String publicUid) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/chapters/$publicUid/ranking');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;
      final Map<String, dynamic> resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> school(String publicUid) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/chapters/school?uid=$publicUid&token=$token');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;
      final Map<String, dynamic> resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }
}
