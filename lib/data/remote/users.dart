import 'dart:convert';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/device_info%20_service.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/entitlement_info_service.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:purchases_flutter/object_wrappers.dart';

class RemoteUsers {
  // 現在のログインユーザーの取得　　　users/current
  static Future<Map?> current() async {
    try {
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: 'token');

      if (token == null) return null;

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/current?token=$token');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;
      // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // ユーザーの検索
  static Future<Map?> index(String keyword, int pageKey, int pageSize) async {
    try {
      final String? token = await LocalUserInfo.authToken();

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users?keyword=$keyword&page=$pageKey&size=$pageSize&token=$token');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;
      final Map<String, dynamic> resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 特定のユーザー情報を取得
  static Future<Map?> show(String publicUid) async {
    try {
      final String token = await LocalUserInfo.authToken() ?? '';
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/$publicUid?token=$token');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;
      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // ユーザー情報の更新
  static Future<Map?> update(Map<String, dynamic> params) async {
    try {
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');
      final String publicUid = params['public_uid'];

      // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
      final String encodedData =
          json.encode({'user': params, 'token': '$token'});

      // リクエスト
      final url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/$publicUid');

      final Response res = await HttpService.patch(
        url,
        encodedData,
      );
      if (res.statusCode != 200) return null;
      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 解答中の問題集の取得
  static Future<Map?> drillsInProgress() async {
    try {
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: 'token');

      if (token == null) return null;

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/drills_in_progress?token=$token');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;
      // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 実績メダルの取得
  static Future<Map?> achievements(String publicUid) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/$publicUid/achievements');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) {
        return null;
      }
      // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 参加中の教室
  static Future<Map?> schools(String publicUid) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/$publicUid/schools');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) {
        return null;
      }
      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 退会
  static Future<Map?> withdrawal() async {
    try {
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: 'token');
      String? uid = await storage.read(key: 'publicUid');

      if (token == null || uid == null) return null;

      final Uri url =
          Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/$uid');
      final String encodedData = json.encode({'token': token});
      final Response res = await HttpService.delete(url, encodedData);

      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // アプリのレビュー画面を表示したことを伝える
  static Future<Map?> favorApp() async {
    try {
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: 'token');
      if (token == null) return null;

      final deviceInfo = DeviceInfoService();
      final String platform = deviceInfo.getPlatform();
      final String deviceName = await deviceInfo.getName();

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/favor_app');
      final String encodedData = json
          .encode({'token': token, 'device_info': '$platform / $deviceName'});

      final Response res = await HttpService.post(url, encodedData);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 解約理由を送信する
  static Future<Map?> sendCancellationReport(
      EntitlementInfo entitlementInfo, String reason) async {
    try {
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: 'token');
      if (token == null) return null;
      final String productIdentifier = entitlementInfo.productIdentifier;
      final String device = EntitlementInfoService.device(entitlementInfo);
      final bool inTrial = EntitlementInfoService.inTrial(entitlementInfo);

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/send_cancellation_report');
      final String encodedData = json.encode({
        'token': token,
        'product_identifier': productIdentifier,
        'device': device,
        'in_trial': '$inTrial',
        'reason': reason
      });
      final Response res = await HttpService.post(url, encodedData);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // カレンダーのイベントを取得する
  static Future<Map?> loadCalendarEvents(
      String publicUid, DateTime firstDate, DateTime lastDate) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users/$publicUid/calendar?start=$firstDate&end=$lastDate');
      final Response res = await HttpService.get(url);
      if (res.statusCode != 200) return null;
      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }
}
