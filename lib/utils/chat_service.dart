import 'dart:async';
import 'package:booqs_mobile/models/chat/request.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// ChatGPT
// Azure open AIに対応しているSDKがないので、自前で実装する。
// ref: https://pub.aimind.so/step-by-step-guide-to-integrating-openai-api-in-flutter-f85cb0856a9d
// ref: https://blog.jbs.co.jp/entry/2023/06/21/130111
// ref: https://github.com/openai/openai-cookbook/blob/main/examples/How_to_stream_completions.ipynb
class ChatService {
  // streamで取得する場合
  static Future<http.StreamedResponse> stream(
      {required String prompt, required int version}) async {
    final String? endpoint = dotenv.env['AZURE_OPENAI_endpoint'];
    final Map<String, String> deploymentAndModel =
        ChatService.deploymentAndModel(version: version);
    final String deployment = deploymentAndModel['deployment']!;
    final String model = deploymentAndModel['model']!;
    final Uri chatUri = Uri.parse(
        "https://$endpoint.openai.azure.com/openai/deployments/$deployment/chat/completions?api-version=2023-07-01-preview");

    final Map<String, String> headers = header();
    final ChatRequest request = ChatRequest(
        model: model,
        maxTokens: 500,
        stream: true,
        messages: [Message(role: "system", content: prompt)]);

    final http.Client client = http.Client();
    final http.Request httpRequest = http.Request('POST', chatUri)
      ..headers.addAll(headers)
      ..body = request.toJson();
    final http.StreamedResponse streamedResponse =
        await client.send(httpRequest);
    return streamedResponse;
  }

  static Map<String, String> header() {
    final String? openAIApiKey = dotenv.env['AZURE_OPENAI_ACCESS_TOKEN'];
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'api-key': '$openAIApiKey',
    };
    return headers;
  }

  // バージョンごとのデプロイメントとモデルを取得する
  static Map<String, String> deploymentAndModel({required int version}) {
    switch (version) {
      case 3:
        return {
          'deployment': 'diqt-gpt-35-turbo',
          'model': 'gpt-35-turbo-0613'
        };
      case 4:
        return {'deployment': 'diqt-gpt-4', 'model': 'gpt-4-0613'};
      default:
        return {
          'deployment': 'diqt-gpt-35-turbo',
          'model': 'gpt-35-turbo-0613'
        };
    }
  }
}
