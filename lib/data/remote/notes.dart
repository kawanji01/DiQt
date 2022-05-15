import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:http/http.dart';

class RemoteNotes {
  static Future<Map?> create(Map<String, dynamic> params) async {
    final String? token = await LocalUserInfo.authToken();
    if (token == null) return null;

    // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
    final String encodedData = json.encode({'note': params, 'token': token});
    final Map<String, String> headers = {'content-type': 'application/json'};

    final Uri url =
        Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/notes');
    final Response res = await post(
      url,
      headers: headers,
      body: encodedData,
    );
    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }

  static Future<Map?> update(Map<String, dynamic> params) async {
    final String? token = await LocalUserInfo.authToken();
    if (token == null) return null;

    // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
    final String encodedData = json.encode({'note': params, 'token': token});
    final Map<String, String> headers = {'content-type': 'application/json'};

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/notes/${params['id']}');
    final Response res = await patch(
      url,
      headers: headers,
      body: encodedData,
    );
    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }
}
