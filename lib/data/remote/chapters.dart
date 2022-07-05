import 'dart:convert';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:http/http.dart';

class RemoteChapters {
  static Future<Map?> index() async {
    Uri url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/api/v1/mobile/chapters');
    Response res =
        await get(url, headers: {"Content-Type": "application/json"});
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map<String, dynamic> resMap = json.decode(res.body);
    return resMap;
  }

  static Future<Map?> show(String publicUid) async {
    final String? token = await LocalUserInfo.authToken();
    Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/chapters/$publicUid?token=$token');
    Response res =
        await get(url, headers: {"Content-Type": "application/json"});

    if (res.statusCode != 200) return null;
    Map<String, dynamic> resMap = json.decode(res.body);
    return resMap;
  }

  static Future<Map?> activities(
      String publicUid, int pageKey, int pageSize) async {
    final String? token = await LocalUserInfo.authToken();
    Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/chapters/$publicUid/activities?page=$pageKey&size=$pageSize&token=$token');
    Response res =
        await get(url, headers: {"Content-Type": "application/json"});

    if (res.statusCode != 200) return null;
    Map<String, dynamic> resMap = json.decode(res.body);
    return resMap;
  }

  static Future<Map?> ranking(String publicUid) async {
    Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/chapters/$publicUid/ranking');
    Response res =
        await get(url, headers: {"Content-Type": "application/json"});

    if (res.statusCode != 200) return null;
    Map<String, dynamic> resMap = json.decode(res.body);
    return resMap;
  }
}
