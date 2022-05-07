import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:http/http.dart';

class RemoteDrills {
  // 未解答の問題を取得する
  static Future<Map?> unsolved(String publicUid, String order) async {
    final String? token = await LocalUserInfo.authToken();
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/drills/$publicUid/unsolved?token=$token&order=$order');
    final Response res =
        await get(url, headers: {"Content-Type": "application/json"});

    if (res.statusCode != 200) return null;
    Map<String, dynamic> resMap = json.decode(res.body);
    return resMap;
  }

  // 解答済の問題
  static Future<Map?> solved(
      String publicUid, int pageKey, int pageSize, String order) async {
    final String? token = await LocalUserInfo.authToken();
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/drills/$publicUid/solved?order=$order&page=$pageKey&size=$pageSize&token=$token');
    final Response res =
        await get(url, headers: {"Content-Type": "application/json"});

    if (res.statusCode != 200) return null;
    final Map<String, dynamic> resMap = json.decode(res.body);
    return resMap;
  }

  // すべての問題
  static Future<Map?> show(
      String publicUid, int pageKey, int pageSize, String order) async {
    final String? token = await LocalUserInfo.authToken();
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/drills/$publicUid?order=$order&page=$pageKey&size=$pageSize&token=$token');
    final Response res =
        await get(url, headers: {"Content-Type": "application/json"});

    if (res.statusCode != 200) return null;
    final Map<String, dynamic> resMap = json.decode(res.body);
    return resMap;
  }

  // 新しい周回を始める
  static Future<Map?> newLap(String publicUid) async {
    final String? token = await LocalUserInfo.authToken();
    if (token == null) return null;

    Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/drills/$publicUid/new_lap');
    Map boby = {
      'token': token,
    };
    final Response res = await post(url, body: boby);
    if (res.statusCode != 200) return null;
    Map<String, dynamic> resMap = json.decode(res.body);
    return resMap;
  }
}
