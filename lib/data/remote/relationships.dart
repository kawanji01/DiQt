import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/models/relationship.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:http/http.dart';

class RemoteRelationships {
  // フォロー。フォローする相手のUIDを引数にする
  static Future<Map?> create(String publicUid) async {
    final String? token = await LocalUserInfo.authToken();
    if (token == null) return null;

    final String encodedData =
        json.encode({'token': token, 'public_uid': publicUid});
    final Map<String, String> headers = {'content-type': 'application/json'};

    final Uri url =
        Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/relationships');
    final Response res = await post(
      url,
      headers: headers,
      body: encodedData,
    );
    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }

  static Future<Map?> destroy(Relationship relationship) async {
    final String? token = await LocalUserInfo.authToken();
    if (token == null) return null;

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/relationships/${relationship.id}');
    final Response res = await delete(url, body: {
      'token': token,
    });
    if (res.statusCode != 200) return null;

    Map resMap = json.decode(res.body);
    return resMap;
  }

  // LazyFollowButtonであと読みでrelationshipを取得する
  static Future<Map?> find(String publicUid) async {
    final String? token = await LocalUserInfo.authToken();
    if (token == null) return null;

    final Map<String, String> headers = {'content-type': 'application/json'};

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/relationships/find?public_uid=$publicUid&token=$token');
    final Response res = await get(
      url,
      headers: headers,
    );
    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }
}
