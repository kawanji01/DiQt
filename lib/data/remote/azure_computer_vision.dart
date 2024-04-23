import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AzureComputerVision {
  // 画像からテキストを取得する
  static Future<String?> analyzeImageBinary(
      {required File imageData, required String language}) async {
    try {
      final String? endpoint = dotenv.env['AZURE_COMPUTER_VISION_ENDPOINT'];
      final String? subscriptionKey =
          dotenv.env['AZURE_COMPUTER_VISION_SUBSCRIPTION_KEY'];

      final Uri url = Uri.parse(
          '$endpoint/computervision/imageanalysis:analyze?api-version=2023-02-01-preview&features=read&language=$language');
      final Map<String, String> headers = {
        'Ocp-Apim-Subscription-Key': '$subscriptionKey',
        'Content-Type': 'application/octet-stream'
      };
      final res = await http.post(
        url,
        headers: headers,
        body: imageData.readAsBytesSync(),
      );
      final Map resMap = json.decode(res.body);
      final String text = resMap['readResult']['content'];
      return text;
    } on TimeoutException {
      return null;
    } on SocketException {
      return null;
    } catch (e) {
      return null;
    }
  }
}
