import 'dart:convert';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart';

class RemoteDictionaries {
  static Future<Map?> index() async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionaries');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;
      final Map<String, dynamic> resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 辞書情報
  static Future<Map?> show(int dictionaryId) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionaries/$dictionaryId');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;
      final Map<String, dynamic> resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 項目の素早い検索
  // 単語・熟語の検索
  static Future<Map?> search(
      int dictionaryId, String keyword, int pageKey, int pageSize) async {
    try {
      final String? token = await LocalUserInfo.authToken();

      final String encodedData = json.encode({
        'keyword': keyword,
        'page': pageKey,
        'size': pageSize,
        'token': '$token'
      });

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionaries/$dictionaryId/search');
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

  // 単語・熟語の検索
  static Future<Map?> wordSearch(
      int dictionaryId, String keyword, int pageKey, int pageSize) async {
    try {
      final String? token = await LocalUserInfo.authToken();

      final String encodedData = json.encode({
        'keyword': keyword,
        'page': pageKey,
        'size': pageSize,
        'token': '$token'
      });

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionaries/$dictionaryId/word_search');
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

  // 例文の検索
  static Future<Map?> sentenceSearch(
      int dictionaryId, String keyword, int pageKey, int pageSize) async {
    try {
      final String? token = await LocalUserInfo.authToken();

      final String encodedData = json.encode({
        'keyword': keyword,
        'page': pageKey,
        'size': pageSize,
        'token': '$token'
      });

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionaries/$dictionaryId/sentence_search');
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
}
