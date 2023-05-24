import 'dart:convert';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart';

class RemoteWords {
  // 取得
  static Future<Map?> show(int wordId) async {
    try {
      final String? token = await LocalUserInfo.authToken();

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/words/$wordId?token=$token');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> newWord(int dictionaryId, String keyword) async {
    try {
      final String? token = await LocalUserInfo.authToken();

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/words/new?dictionary_id=$dictionaryId&keyword=$keyword&token=$token');
      final Response res = await HttpService.get(
        url,
      );

      if (res.statusCode != 200) return null;
      final Map? resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 編集
  static Future<Map?> edit(int wordId) async {
    try {
      final String? token = await LocalUserInfo.authToken();

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/words/$wordId/edit?token=$token');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 新規作成
  static Future<Map?> create(Map<String, dynamic> params) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
      final String encodedData =
          json.encode({'word': params, 'token': '$token'});

      final Uri url =
          Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/words');
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

  // 更新
  static Future<Map?> update(Map<String, dynamic> params) async {
    try {
      final String? token = await LocalUserInfo.authToken();

      // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
      final String encodedData =
          json.encode({'word': params, 'token': '$token'});

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/words/${params['id']}');
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

  // 削除
  static Future<Map?> destroy(int wordId) async {
    try {
      final String? token = await LocalUserInfo.authToken();

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/words/$wordId');
      final String encodedData = json.encode({'token': '$token'});
      final Response res = await HttpService.delete(url, encodedData);

      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  //
  static Future<Map?> search(int dictionaryId, String? keyword) async {
    try {
      final String? token = await LocalUserInfo.authToken();

      if (keyword == null) return null;
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/words/search');
      final String encodedData = json.encode({
        'dictionary_id': '$dictionaryId',
        'keyword': keyword,
        'token': '$token'
      });
      final Response res = await HttpService.post(url, encodedData);
      if (res.statusCode != 200) return null;
      // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
      Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 自動補完 GETGETGET
  static Future<Map?> autocomplete(int dictionaryId, String query) async {
    try {
      // 次のアップデートでwords/に戻す。
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionaries/$dictionaryId/autocomplete?query=$query');

      final Response res = await HttpService.get(url);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }
}
