import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:http/http.dart';

class RemoteWeaknesses {
  // 未解答の弱点問題を取得する
  static Future<Map?> index(String sort, String order) async {
    final String? token = await LocalUserInfo.authToken();
    if (token == null) return null;

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/weaknesses?order=$order&sort=$sort&token=$token');
    final Response res = await get(url);

    if (res.statusCode != 200) return null;

    final Map resMap = json.decode(res.body);
    return resMap;
  }

  // 弱点問題をすべて未解答に戻す
  static Future<Map?> newLap() async {
    final String? token = await LocalUserInfo.authToken();
    if (token == null) return null;

    final String encodedData = json.encode({'token': token});
    final Map<String, String> headers = {'content-type': 'application/json'};

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/weaknesses/new_lap');
    final Response res = await patch(url, headers: headers, body: encodedData);

    if (res.statusCode != 200) return null;

    final Map resMap = json.decode(res.body);
    return resMap;
  }
}
