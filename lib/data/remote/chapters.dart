import 'dart:convert';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:http/http.dart';

class RemoteChapters {
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
}
