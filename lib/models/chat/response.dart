import 'dart:convert';
import 'package:booqs_mobile/models/chat/request.dart';
import 'package:http/http.dart';

class ChatResponse {
  final String? id;
  final String object;
  final int? created;
  final String? model;
  final List<Choice>? choices;
  final Usage usage;

  const ChatResponse({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
  });

  factory ChatResponse.fromResponse(Response response) {
    if (response.statusCode != 200) {
      throw Exception('Failed to load data: ${response.body}');
    }
    String responseBody = utf8.decode(response.bodyBytes);
    print('responseBody: $responseBody');
    print('OK: OKOKOK');
    Map<String, dynamic> parsedBody = json.decode(responseBody);
    print('parsedBody: $parsedBody');
    return ChatResponse(
      id: parsedBody['id'],
      object: parsedBody['object'],
      created: parsedBody['created'],
      model: parsedBody['model'],
      choices: List<Choice>.from(
          parsedBody['choices'].map((choice) => Choice.fromJson(choice))),
      usage: Usage.fromJson(parsedBody['usage']),
    );
  }
}

class Choice {
  final int? index;
  final Message? message;
  final String? finishReason;

  Choice(this.index, this.message, this.finishReason);

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      json['index'],
      Message.fromJson(json['message']),
      json['finish_reason'],
    );
  }
}

class Usage {
  final int? promptTokens;
  final int? completionTokens;
  final int? totalTokens;

  Usage({this.promptTokens, this.completionTokens, this.totalTokens});

  factory Usage.fromJson(Map<String, dynamic> json) {
    return Usage(
      promptTokens: json['prompt_tokens'],
      completionTokens: json['completion_tokens'],
      totalTokens: json['total_tokens'],
    );
  }
}
