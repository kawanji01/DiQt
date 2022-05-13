import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RemoteWords {
  // 取得
  static Future<Map?> show(int id) async {
    final String? token = await LocalUserInfo.authToken();
    final Map<String, String> headers = {'content-type': 'application/json'};
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/words/$id?token=$token');
    final Response res = await get(
      url,
      headers: headers,
    );

    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }

  static Future<Map?> newWord(int dictionaryId, String keyword) async {
    final String? token = await LocalUserInfo.authToken();
    final Map<String, String> headers = {'content-type': 'application/json'};
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/words/new?dictionary_id=$dictionaryId&keyword=$keyword&token=$token');
    final Response res = await get(
      url,
      headers: headers,
    );

    if (res.statusCode != 200) return null;
    final Map? resMap = json.decode(res.body);
    return resMap;
  }

  // 編集
  static Future<Map?> edit(int wordId) async {
    final String? token = await LocalUserInfo.authToken();
    final Map<String, String> headers = {'content-type': 'application/json'};
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/words/$wordId/edit?token=$token');
    final Response res = await get(
      url,
      headers: headers,
    );

    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }

  // 新規作成
  static Future<Map?> create(Map<String, dynamic> params) async {
    final String? token = await LocalUserInfo.authToken();

    // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
    final String encodedData = json.encode({'word': params, 'token': '$token'});
    final Map<String, String> headers = {'content-type': 'application/json'};

    final Uri url =
        Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/words');
    final Response res = await post(
      url,
      headers: headers,
      body: encodedData,
    );
    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }

  // 更新
  static Future<Map?> update(Map<String, dynamic> params) async {
    final String? token = await LocalUserInfo.authToken();

    // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
    final String encodedData = json.encode({'word': params, 'token': '$token'});
    final Map<String, String> headers = {'content-type': 'application/json'};

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/words/${params['id']}');
    final Response res = await patch(
      url,
      headers: headers,
      body: encodedData,
    );
    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }

  // 検索
  static Future<Map?> search(String? keyword) async {
    final String? token = await LocalUserInfo.authToken();

    if (keyword == null) return null;
    final Uri url =
        Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/words/search');
    final Response res = await post(url,
        body: {'dictionary_id': '1', 'keyword': keyword, 'token': '$token'});
    if (res.statusCode != 200) return null;
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map resMap = json.decode(res.body);
    return resMap;
  }

  //
  static Future<Map?> search2(int dictionaryId, String? keyword) async {
    final String? token = await LocalUserInfo.authToken();

    if (keyword == null) return null;
    final Uri url =
        Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/words/search2');
    final Response res = await post(url, body: {
      'dictionary_id': '$dictionaryId',
      'keyword': keyword,
      'token': '$token'
    });
    if (res.statusCode != 200) return null;
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map resMap = json.decode(res.body);
    return resMap;
  }

  // 復習の取得
  static Future<Map?> review(BuildContext context, int wordId) async {
    final String? token = await LocalUserInfo.authToken();

    final Uri url = Uri.parse(
        '${DiQtURL.root(context)}/api/v1/mobile/words/$wordId/review');
    final Response res = await post(url, body: {'token': '$token'});
    if (res.statusCode != 200) return null;

    final Map resMap = json.decode(res.body);
    return resMap;
  }
}
