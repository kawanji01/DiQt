import 'dart:async';
import 'dart:convert';
import 'package:booqs_mobile/data/local/secrets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class HttpService {
  // GET
  static Future<http.Response> get(Uri url) async {
    final Map<String, String> headers = await HttpService.headers();

    final http.Client client = http.Client();
    return client
        .get(
      url,
      headers: headers,
    )
        .timeout(const Duration(seconds: 20), onTimeout: () {
      throw TimeoutException('The connection has timed out!');
    });
  }

  // POST
  static Future<http.Response> post(Uri url, Map<String, dynamic>? body) async {
    final Map<String, String> headers = await HttpService.headers();
    // Map<String, dynamic> を boby で送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
    final String encodedBody = json.encode(body);

    final http.Client client = http.Client();
    return client
        .post(
      url,
      headers: headers,
      body: encodedBody,
    )
        .timeout(const Duration(seconds: 20), onTimeout: () {
      throw TimeoutException('The connection has timed out!');
    });
  }

  // PATCH
  static Future<http.Response> patch(
      Uri url, Map<String, dynamic>? body) async {
    final Map<String, String> headers = await HttpService.headers();
    final String encodedBody = json.encode(body);

    final http.Client client = http.Client();
    return client
        .patch(
      url,
      headers: headers,
      body: encodedBody,
    )
        .timeout(const Duration(seconds: 20), onTimeout: () {
      throw TimeoutException('The connection has timed out!');
    });
  }

  // DELETE
  static Future<http.Response> delete(
      Uri url, Map<String, dynamic>? body) async {
    final Map<String, String> headers = await HttpService.headers();
    final String encodedBody = json.encode(body);
    final http.Client client = http.Client();
    return client
        .delete(
      url,
      headers: headers,
      body: encodedBody,
    )
        .timeout(const Duration(seconds: 20), onTimeout: () {
      throw TimeoutException('The connection has timed out!');
    });
  }

  // 画像アップロード
  static Future<http.StreamedResponse> multipartRequest(
      {required Uri url, required XFile image}) async {
    final request = http.MultipartRequest('POST', url);
    // ヘッダーを追加
    final Map<String, String> headers =
        await HttpService.headers(multipart: true);
    request.headers.addAll(headers);
    //
    request.files.add(await http.MultipartFile.fromPath(
      'image', // サーバ側で受け取るパラメータ名を設定
      image.path,
    ));
    return request.send().timeout(const Duration(seconds: 20), onTimeout: () {
      throw TimeoutException('The connection has timed out!');
    });
  }

  // headerを生成する
  static Future<Map<String, String>> headers({bool multipart = false}) async {
    // ネイティブアプリ用のAPIキーとシークレットキー
    final String? apiKey = dotenv.env['NATIVE_API_KEY'];
    final String? secret = dotenv.env['NATIVE_SECRET_KEY'];
    if (apiKey == null || secret == null) {
      return {'content-type': 'application/json'};
    }
    // Rails側で基本認証（Basic Authentication）するための処理
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$apiKey:$secret'))}';

    final String? token = await LocalSecrets.authToken();

    // multipartRequest用のheader
    if (multipart) {
      return <String, String>{
        'authorization': basicAuth,
        'X-User-Token': '$token',
      };
    }
    // 通常のリクエストのheader
    return <String, String>{
      'content-type': 'application/json',
      'authorization': basicAuth,
      'X-User-Token': '$token',
    };
  }
}
