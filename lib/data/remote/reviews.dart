import 'dart:convert';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart';

class RemoteReviews {
  // 復習問題一覧
  static Future<Map?> index(String? order) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/reviews?order=$order&token=$token');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 予定
  static Future<Map?> scheduled(int pageKey, int pageSize, String order) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/reviews/scheduled?order=$order&page=$pageKey&size=$pageSize&token=$token');
      final Response res = await HttpService.get(url);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // すべて
  static Future<Map?> all(int pageKey, int pageSize, String order) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/reviews/all?order=$order&page=$pageKey&size=$pageSize&token=$token');
      final Response res = await HttpService.get(url);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 復習設定の新規作成
  static Future<Map?> create(int quizId) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final Uri url =
          Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/reviews');
      final String encodedData = json.encode({
        'token': token,
        'quiz_id': '$quizId',
      });

      final Response res = await HttpService.post(url, encodedData);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 復習設定の更新
  static Future<Map?> update(int reviewId, int intervalSetting) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/reviews/$reviewId');
      final String encodedData =
          json.encode({'token': token, 'interval_setting': '$intervalSetting'});

      final Response res = await HttpService.patch(url, encodedData);

      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 復習設定の削除
  static Future<Map?> destroy(int reviewId) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/reviews/$reviewId');
      final String encodedData = json.encode({
        'token': token,
      });

      final Response res = await HttpService.delete(url, encodedData);
      if (res.statusCode != 200) return null;

      Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 復習の全削除
  static Future<Map?> destroyAll() async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/reviews/destroy_all');
      final String encodedData = json.encode({
        'token': token,
      });
      final Response res = await HttpService.delete(url, encodedData);
      if (res.statusCode != 200) return null;

      Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }
}
