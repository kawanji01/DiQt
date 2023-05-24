import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/models/relationship.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart';

class RemoteRelationships {
  // フォロー。フォローする相手のUIDを引数にする
  static Future<Map?> create(String publicUid) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final String encodedData =
          json.encode({'token': token, 'public_uid': publicUid});

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/relationships');
      final Response res = await HttpService.post(
        url,
        encodedData,
      );
      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> destroy(Relationship relationship) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/relationships/${relationship.id}');
      final String encodedData = json.encode({
        'token': token,
      });
      final Response res = await HttpService.delete(url, encodedData);
      if (res.statusCode != 200) return null;

      Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }
}
