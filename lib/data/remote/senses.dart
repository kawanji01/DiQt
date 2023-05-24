import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart';

class RemoteSenses {
  //
  static Future<Map?> show(int sentenceId) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/senses/$sentenceId?token=$token');
      final Response res = await HttpService.get(url);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  //
  static Future<Map?> newSense(int wordId) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/senses/new?word_id=$wordId&token=$token');
      final Response res = await HttpService.get(url);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  //
  static Future<Map?> edit(int senseId) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/senses/$senseId/edit?token=$token');
      final Response res = await HttpService.get(url);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  //
  static Future<Map?> create(Map<String, dynamic> params) async {
    try {
      final String? token = await LocalUserInfo.authToken();

      // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
      final String encodedData =
          json.encode({'sense': params, 'token': '$token'});

      final Uri url =
          Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/senses');
      final Response res = await HttpService.post(url, encodedData);
      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  //
  static Future<Map?> update(Map<String, dynamic> params) async {
    try {
      final String? token = await LocalUserInfo.authToken();

      // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
      final String encodedData =
          json.encode({'sense': params, 'token': '$token'});

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/senses/${params['id']}');
      final Response res = await HttpService.patch(
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

  //
  static Future<Map?> destroy(int senseId) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/senses/$senseId');
      final String encodedData = json.encode({'token': '$token'});
      final Response res = await HttpService.delete(url, encodedData);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }
}
