import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AzureComputerVision {
  // 画像からテキストを取得
  static Future<String?> analyzeImageBinary({
    required File imageData,
    required String language, // 例: 'ja'
  }) async {
    try {
      final endpoint = dotenv.env['AZURE_COMPUTER_VISION_ENDPOINT']; // ← 新リソース
      final key = dotenv.env['AZURE_COMPUTER_VISION_SUBSCRIPTION_KEY'];

      final url = Uri.parse(
        '$endpoint/computervision/imageanalysis:analyze'
        '?api-version=2023-10-01'
        '&features=read'
        '&language=$language',
      );

      final res = await http.post(
        url,
        headers: {
          'Ocp-Apim-Subscription-Key': key!,
          'Content-Type': 'application/octet-stream',
        },
        body: await imageData.readAsBytes(),
      );

      if (res.statusCode != 200) throw 'HTTP ${res.statusCode}: ${res.body}';

      final jsonBody = json.decode(res.body) as Map<String, dynamic>;
      // print(jsonBody);

      if (jsonBody['readResult'] == null) {
        throw 'Failed to analyze image: ${jsonBody.toString()}';
      }
      final Map<String, dynamic> readResult = jsonBody['readResult'];

      // blocksから全てのテキストを取得して結合
      final List<dynamic> blocks = readResult['blocks'] as List<dynamic>;
      // print(blocks);
      final String text = blocks
          .expand((block) => (block['lines'] as List<dynamic>))
          .map((line) => line['text'] as String)
          .join('');

      return text;
    } on SocketException {
      return null; // ネットワークエラー
    } catch (e) {
      return null; // その他エラー
    }
  }
}
