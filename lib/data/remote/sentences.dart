import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RemoteSentences {
  // 復習の読み込み
  static Future<Map?> review(BuildContext context, int sentenceId) async {
    final String? token = await LocalUserInfo.authToken();

    final Uri url = Uri.parse(
        '${DiQtURL.root(context)}/api/v1/mobile/sentences/$sentenceId/review');
    final Response res = await post(url, body: {'token': '$token'});
    if (res.statusCode != 200) return null;

    final Map resMap = json.decode(res.body);
    return resMap;
  }
}
