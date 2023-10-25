import 'dart:convert';

// ChatGPT
// ref: https://pub.aimind.so/step-by-step-guide-to-integrating-openai-api-in-flutter-f85cb0856a9d
class ChatRequest {
  final String model;
  final List<Message> messages;
  final int? maxTokens;
  final double? temperature;
  final int? topP;
  final int? n;
  final bool? stream;
  final double? presencePenalty;
  final double? frequencyPenalty;
  final String? stop;

  ChatRequest({
    required this.model,
    required this.messages,
    this.maxTokens,
    this.temperature,
    this.topP,
    this.n,
    this.stream,
    this.presencePenalty,
    this.frequencyPenalty,
    this.stop,
  });

  String toJson() {
    Map<String, dynamic> jsonBody = {
      'model': model,
      'messages': List<Map<String, dynamic>>.from(
          messages.map((message) => message.toJson())),
    };
    if (maxTokens != null) {
      jsonBody.addAll({'max_tokens': maxTokens});
    }

    if (temperature != null) {
      jsonBody.addAll({'temperature': temperature});
    }

    if (topP != null) {
      jsonBody.addAll({'top_p': topP});
    }

    if (n != null) {
      jsonBody.addAll({'n': n});
    }

    if (stream != null) {
      jsonBody.addAll({'stream': stream});
    }

    if (presencePenalty != null) {
      jsonBody.addAll({'presence_penalty': presencePenalty});
    }

    if (frequencyPenalty != null) {
      jsonBody.addAll({'frequency_penalty': frequencyPenalty});
    }

    if (stop != null) {
      jsonBody.addAll({'stop': stop});
    }

    return json.encode(jsonBody);
  }
}

class Message {
  final String? role;
  final String? content;

  Message({this.role, this.content});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      role: json['role'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }
}
