import 'dart:convert';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/services/device_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class RemoteUsers {
  // 現在のログインユーザーの取得　　　users/current
  static Future<Map?> current() async {
    const storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');

    if (token == null) return null;

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/current?token=$token');
    final Response res = await get(url);

    if (res.statusCode != 200) return null;
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    final Map resMap = json.decode(res.body);
    return resMap;
  }

  // ユーザーの検索
  static Future<Map?> index(String keyword, int pageKey, int pageSize) async {
    final String? token = await LocalUserInfo.authToken();

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users?keyword=$keyword&page=$pageKey&size=$pageSize&token=$token');
    final Response res =
        await get(url, headers: {"Content-Type": "application/json"});

    if (res.statusCode != 200) return null;
    final Map<String, dynamic> resMap = json.decode(res.body);
    return resMap;
  }

  // 特定のユーザー情報を取得
  static Future<Map?> show(String publicUid) async {
    final String token = await LocalUserInfo.authToken() ?? '';
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/$publicUid?token=$token');
    final Response res = await get(url);

    if (res.statusCode != 200) return null;
    final Map resMap = json.decode(res.body);
    return resMap;
  }

  // 解答中の問題集の取得
  static Future<Map?> drillsInProgress() async {
    const storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');

    if (token == null) return null;

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/drills_in_progress?token=$token');
    final Response res = await get(url);

    if (res.statusCode != 200) return null;
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    final Map resMap = json.decode(res.body);
    return resMap;
  }

  // 実績メダルの取得
  static Future<Map?> achievements(String publicUid) async {
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/$publicUid/achievements');
    final Response res =
        await get(url, headers: {"Content-Type": "application/json"});

    if (res.statusCode != 200) {
      return null;
    }
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    final Map resMap = json.decode(res.body);
    return resMap;
  }

  // 参加中の教室
  static Future<Map?> schools(String publicUid) async {
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/$publicUid/schools');
    final Response res =
        await get(url, headers: {"Content-Type": "application/json"});

    if (res.statusCode != 200) {
      return null;
    }
    final Map resMap = json.decode(res.body);
    return resMap;
  }

  // 退会
  static Future<Map?> withdrawal() async {
    const storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');
    String? uid = await storage.read(key: 'publicUid');

    if (token == null || uid == null) return null;

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/$uid?token=$token');
    final Response res = await delete(url);

    if (res.statusCode != 200) return null;

    final Map resMap = json.decode(res.body);
    return resMap;
  }

  // アプリのレビュー画面を表示したことを伝える
  static Future<Map?> favorApp() async {
    const storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');
    if (token == null) return null;

    final deviceInfo = DeviceInfoService();
    final String platform = deviceInfo.getPlatform();
    final String deviceName = await deviceInfo.getName();

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/favor_app');
    final Map boby = {'token': token, 'device_info': '$platform / $deviceName'};
    final Response res = await post(url, body: boby);
    if (res.statusCode != 200) return null;

    final Map resMap = json.decode(res.body);
    return resMap;
  }
}
