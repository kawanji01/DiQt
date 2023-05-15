import 'dart:async';
import 'package:http/http.dart' as http;

class HttpService {
  // POST
  static Future<http.Response> post(Uri url, String body) async {
    final Map<String, String> headers = {'content-type': 'application/json'};
    final http.Client client = http.Client();
    return client
        .post(
      url,
      headers: headers,
      body: body,
    )
        .timeout(const Duration(seconds: 10), onTimeout: () {
      throw TimeoutException('The connection has timed out!');
    });
  }

  // DELETE
  static Future<http.Response> delete(Uri url, String body) async {
    final Map<String, String> headers = {'content-type': 'application/json'};
    final http.Client client = http.Client();
    return client
        .delete(
      url,
      headers: headers,
      body: body,
    )
        .timeout(const Duration(seconds: 10), onTimeout: () {
      throw TimeoutException('The connection has timed out!');
    });
  }
}
