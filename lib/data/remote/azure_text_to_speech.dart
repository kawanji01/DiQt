import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AzureTextToSpeech {
  // Bearerトークンを取得
  static Future<String?> fetchAzureTTSToken() async {
    final String? tokenEndpoint = dotenv.env['AZURE_TTS_TOKEN_ENDPOINT'];
    final String? subscriptionKey = dotenv.env['AZURE_TTS_SUBSCRIPTION_KEY'];
    if (tokenEndpoint == null || subscriptionKey == null) {
      return null;
    }
    final headers = {
      'Ocp-Apim-Subscription-Key': subscriptionKey,
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    try {
      final res = await http.post(Uri.parse(tokenEndpoint), headers: headers);
      if (res.statusCode == 200) {
        return res.body;
      } else {
        // print('Token fetch error: ${res.statusCode}, ${res.body}');
        return null;
      }
    } catch (e) {
      // print('Token fetch exception: $e');
      return null;
    }
  }

  // SSMLから音声データを取得（エラー内容も返す）
  static Future<Map<String, dynamic>> synthesizeSSML(String ssml) async {
    final String? endpoint = dotenv.env['AZURE_TTS_ENDPOINT'];
    if (endpoint == null) {
      final msg = 'Azure TTS endpoint is not set.';
      // print(msg);
      return {'audioBytes': null, 'error': msg};
    }
    final String? token = await fetchAzureTTSToken();
    if (token == null) {
      final msg = 'Failed to fetch Azure TTS Bearer token.';
      // print(msg);
      return {'audioBytes': null, 'error': msg};
    }
    final Uri url = Uri.parse(endpoint);
    // print('TTSリクエストURL: $url');
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/ssml+xml',
      'X-Microsoft-OutputFormat': 'audio-24khz-48kbitrate-mono-mp3',
    };
    try {
      final http.Response res = await http.post(
        url,
        headers: headers,
        body: ssml,
      );
      if (res.statusCode == 200) {
        // print('Azure TTS audioBytes.length: \\${res.bodyBytes.length}');
        return {'audioBytes': res.bodyBytes, 'error': null};
      } else {
        final msg =
            'Azure TTS error: status=${res.statusCode}, body=${res.body}, url=$url';
        // print(msg);
        return {'audioBytes': null, 'error': msg};
      }
    } catch (e) {
      // print('Azure TTS exception: $e');
      return {'audioBytes': null, 'error': e.toString()};
    }
  }
}
