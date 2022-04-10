import 'dart:convert';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RemoteReviews {
  // 復習問題一覧
  static Future<Map?> index(BuildContext context) async {
    final String? token = await LocalUserInfo.authToken();
    if (token == null) return null;

    final Uri url = Uri.parse(
        '${DiQtURL.root(context)}/api/v1/mobile/reviews?token=$token');
    final Response res = await get(url);

    if (res.statusCode != 200) return null;

    final Map resMap = json.decode(res.body);
    return resMap;
  }

  // 復習設定の新規作成
  static Future<Map?> create(
      BuildContext context, int quizId, String? intervalSetting) async {
    final String? token = await LocalUserInfo.authToken();
    if (token == null) return null;

    final Uri url = Uri.parse('${DiQtURL.root(context)}/api/v1/mobile/reviews');
    Map boby = {
      'token': token,
      'quiz_id': '$quizId',
    };
    if (intervalSetting != null) {
      boby['interval_setting'] = intervalSetting;
    }

    final Response res = await post(url, body: boby);
    if (res.statusCode != 200) return null;

    final Map resMap = json.decode(res.body);
    return resMap;
  }

  // 復習設定の更新
  static Future<Map?> update(
      BuildContext context, int reviewId, String intervalSetting) async {
    final String? token = await LocalUserInfo.authToken();
    if (token == null) return null;

    final Uri url =
        Uri.parse('${DiQtURL.root(context)}/api/v1/mobile/reviews/$reviewId');
    final Response res = await patch(url,
        body: {'token': token, 'interval_setting': intervalSetting});

    if (res.statusCode != 200) return null;

    final Map resMap = json.decode(res.body);
    return resMap;
  }

  // 復習設定の削除
  static Future<Map?> destroy(BuildContext context, int reviewId) async {
    final String? token = await LocalUserInfo.authToken();
    if (token == null) return null;

    final Uri url =
        Uri.parse('${DiQtURL.root(context)}/api/v1/mobile/reviews/$reviewId');
    final Response res = await delete(url, body: {
      'token': token,
    });
    if (res.statusCode != 200) return null;

    Map resMap = json.decode(res.body);
    return resMap;
  }
}
