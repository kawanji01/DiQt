import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart';

class RemoteNotes {
  // ノート一覧
  static Future<Map?> index(int pageKey, int pageSize, String order) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/notes?order=$order&page=$pageKey&size=$pageSize&token=$token');
      final Response res = await HttpService.get(url);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // ノート作成
  static Future<Map?> create(Map<String, dynamic> params) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
      final String encodedData = json.encode({'note': params, 'token': token});
      final Uri url =
          Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/notes');
      final Response res = await HttpService.post(
        url,
        encodedData,
      );
      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> update(Map<String, dynamic> params) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
      final String encodedData = json.encode({'note': params, 'token': token});

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/notes/${params['id']}');
      final Response res = await HttpService.patch(
        url,
        encodedData,
      );
      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }
}
