import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart';

class RemoteAnswerHistories {
  // 解答履歴（総合）
  static Future<Map?> index(int pageKey, int pageSize) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/answer_histories?page=$pageKey&size=$pageSize&token=$token');
      final Response res = await HttpService.get(url);
      if (res.statusCode != 200) return null;
      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 今日間違えた問題
  static Future<Map?> todaysMistakes(int pageKey, int pageSize) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/answer_histories/todays_mistakes?page=$pageKey&size=$pageSize&token=$token');
      final Response res = await HttpService.get(url);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }
}
