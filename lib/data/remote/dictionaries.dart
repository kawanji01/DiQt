import 'dart:convert';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:http/http.dart';

class RemoteDictionaries {
  static Future<Map?> index() async {
    final Uri url =
        Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionaries');
    final Response res =
        await get(url, headers: {"Content-Type": "application/json"});

    if (res.statusCode != 200) return null;
    final Map<String, dynamic> resMap = json.decode(res.body);
    return resMap;
  }

  // 辞書情報
  static Future<Map?> show(int dictionaryId) async {
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionaries/$dictionaryId');
    final Response res =
        await get(url, headers: {"Content-Type": "application/json"});

    if (res.statusCode != 200) return null;
    final Map<String, dynamic> resMap = json.decode(res.body);
    return resMap;
  }

  // 項目の素早い検索
  // 単語・熟語の検索
  static Future<Map?> search(
      int dictionaryId, String keyword, int pageKey, int pageSize) async {
    final String? token = await LocalUserInfo.authToken();

    final String encodedData = json.encode({
      'keyword': keyword,
      'page': pageKey,
      'size': pageSize,
      'token': '$token'
    });
    final Map<String, String> headers = {'content-type': 'application/json'};

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionaries/$dictionaryId/search');
    final Response res = await post(
      url,
      headers: headers,
      body: encodedData,
    );
    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }

  // 単語・熟語の検索
  static Future<Map?> wordSearch(
      int dictionaryId, String keyword, int pageKey, int pageSize) async {
    final String? token = await LocalUserInfo.authToken();

    final String encodedData = json.encode({
      'keyword': keyword,
      'page': pageKey,
      'size': pageSize,
      'token': '$token'
    });
    final Map<String, String> headers = {'content-type': 'application/json'};

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionaries/$dictionaryId/word_search');
    final Response res = await post(
      url,
      headers: headers,
      body: encodedData,
    );
    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }

  // 例文の検索
  static Future<Map?> sentenceSearch(
      int dictionaryId, String keyword, int pageKey, int pageSize) async {
    final String? token = await LocalUserInfo.authToken();

    final String encodedData = json.encode({
      'keyword': keyword,
      'page': pageKey,
      'size': pageSize,
      'token': '$token'
    });
    final Map<String, String> headers = {'content-type': 'application/json'};

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionaries/$dictionaryId/sentence_search');
    final Response res = await post(
      url,
      headers: headers,
      body: encodedData,
    );
    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }
}
