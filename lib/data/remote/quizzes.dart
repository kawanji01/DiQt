import 'dart:convert';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class RemoteQuizzes {
  // 問題を解答する / quizzes/:id/answer
  static Future<Map?> answer(BuildContext context,
      AnswerNotification notification, String answerType) async {
    final Quiz quiz = notification.quiz;

    const storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');
    if (token == null) return null;

    final Uri url = Uri.parse(
        '${DiQtURL.root(context)}/api/v1/mobile/quizzes/${quiz.id}/answer');
    final Response res = await post(url, body: {
      'token': token,
      'answer': notification.usersAnswer,
      'correct': '${notification.correct}',
      'answer_type': answerType,
    });

    if (res.statusCode != 200) return null;
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    final Map resMap = json.decode(res.body);
    return resMap;
  }
}
