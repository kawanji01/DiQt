import 'dart:convert';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:http/http.dart';

class RemoteDictionaries {
  static Future<Map?> index() async {
    final Uri url =
        Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionaries');
    final Response res =
        await get(url, headers: {"Content-Type": "application/json"});

    if (res.statusCode != 200) return null;
    final Map<String, dynamic> resMap = json.decode(res.body);
    return resMap;
  }

  static Future<Map?> show(String publicUid) async {
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionaries/$publicUid');
    final Response res =
        await get(url, headers: {"Content-Type": "application/json"});

    if (res.statusCode != 200) return null;
    final Map<String, dynamic> resMap = json.decode(res.body);
    return resMap;
  }
}
