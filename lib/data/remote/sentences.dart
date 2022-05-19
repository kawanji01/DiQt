import 'dart:convert';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:http/http.dart';

class RemoteSentences {
  // 例文の読み込み
  static Future<Map?> show(int sentenceId) async {
    final String? token = await LocalUserInfo.authToken();
    final Map<String, String> headers = {'content-type': 'application/json'};
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/sentences/$sentenceId?token=$token');
    final Response res = await get(url, headers: headers);
    if (res.statusCode != 200) return null;

    final Map resMap = json.decode(res.body);
    return resMap;
  }

  //
  static Future<Map?> newSentence(int dictionaryId) async {
    final String? token = await LocalUserInfo.authToken();

    final Map<String, String> headers = {'content-type': 'application/json'};
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/sentences/new?dictionary_id=$dictionaryId&token=$token');
    final Response res = await get(url, headers: headers);
    if (res.statusCode != 200) return null;

    final Map resMap = json.decode(res.body);
    return resMap;
  }

  //
  static Future<Map?> edit(int sentenceId) async {
    final String? token = await LocalUserInfo.authToken();

    final Map<String, String> headers = {'content-type': 'application/json'};
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/sentences/$sentenceId/edit?token=$token');
    final Response res = await get(url, headers: headers);
    if (res.statusCode != 200) return null;

    final Map resMap = json.decode(res.body);
    return resMap;
  }

  // 例文の作成
  static Future<Map?> create(Map<String, dynamic> params) async {
    final String? token = await LocalUserInfo.authToken();

    // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
    final String encodedData =
        json.encode({'sentence': params, 'token': '$token'});
    final Map<String, String> headers = {'content-type': 'application/json'};

    final Uri url =
        Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/sentences');
    final Response res = await post(
      url,
      headers: headers,
      body: encodedData,
    );
    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }

  // 例文の更新
  static Future<Map?> update(Map<String, dynamic> params) async {
    final String? token = await LocalUserInfo.authToken();

    // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
    final String encodedData =
        json.encode({'sentence': params, 'token': '$token'});
    final Map<String, String> headers = {'content-type': 'application/json'};

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/sentences/${params['id']}');
    final Response res = await patch(
      url,
      headers: headers,
      body: encodedData,
    );
    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }

  // 例文の削除
  static Future<Map?> destroy(int sentenceId) async {
    final String? token = await LocalUserInfo.authToken();
    final Map<String, String> headers = {'content-type': 'application/json'};
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/sentences/$sentenceId?token=$token');
    final Response res = await delete(url, headers: headers);
    if (res.statusCode != 200) return null;

    final Map resMap = json.decode(res.body);
    return resMap;
  }

  // 例文検索
  static Future<Map?> search(
      String keyword, int dictionaryId, int pageKey, int pageSize) async {
    final String? token = await LocalUserInfo.authToken();

    // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
    final String encodedData = json.encode({
      'keyword': keyword,
      'dictionary_id': '$dictionaryId',
      'token': token,
      'page': pageKey,
      'size': pageSize
    });
    final Map<String, String> headers = {'content-type': 'application/json'};

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/sentences/search');
    // 検索条件が長い場合に、getだとURLの文字数制限に引っかかる可能性があるのでpostを使う。
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
