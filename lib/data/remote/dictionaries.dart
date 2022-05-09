import 'dart:convert';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:http/http.dart';

class RemoteDictionaries {
  static Future<Map?> index() async {
    Uri url =
        Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionaries');
    Response res =
        await get(url, headers: {"Content-Type": "application/json"});

    if (res.statusCode != 200) return null;
    Map<String, dynamic> resMap = json.decode(res.body);
    return resMap;
  }

  static Future<Map?> show(String publicUid) async {
    Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/dictionaries/$publicUid');
    Response res =
        await get(url, headers: {"Content-Type": "application/json"});

    if (res.statusCode != 200) return null;
    Map<String, dynamic> resMap = json.decode(res.body);
    return resMap;
  }
}
