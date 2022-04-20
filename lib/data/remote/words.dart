import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RemoteWords {
  // 検索
  static Future<Map?> search(String? keyword) async {
    if (keyword == null) return null;
    final Uri url =
        Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/words/search');
    final Response res =
        await post(url, body: {'keyword': '$keyword', 'dictionary_id': '1'});
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
