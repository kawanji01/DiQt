import 'dart:convert';
import 'package:booqs_mobile/data/local/user_info.dart';
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
    final Map resMap = json.decode(res.body);
    return resMap;
  }

  // 問題の解説表示
  static Future<Map?> explanation(int quizId) async {
    final String? token = await LocalUserInfo.authToken();
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/quizzes/$quizId/explanation?token=$token');
    final Response res = await get(url);

    if (res.statusCode != 200) return null;
    final Map resMap = json.decode(res.body);
    return resMap;
  }

  // 問題の詳細を取得
  static Future<Map?> show(int quizId) async {
    final String? token = await LocalUserInfo.authToken();
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/quizzes/$quizId?token=$token');
    final Response res = await get(url);

    if (res.statusCode != 200) return null;

    final Map resMap = json.decode(res.body);
    return resMap;
  }

  static Future<Map?> edit(int quizId) async {
    final String? token = await LocalUserInfo.authToken();
    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/quizzes/$quizId/edit?token=$token');
    final Response res = await get(url);

    if (res.statusCode != 200) return null;

    final Map resMap = json.decode(res.body);
    return resMap;
  }

  static Future<Map?> update(Map params) async {
    final String? token = await LocalUserInfo.authToken();

    // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
    final String encodedData = json.encode({'quiz': params, 'token': '$token'});
    final Map<String, String> headers = {'content-type': 'application/json'};

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/quizzes/${params['id']}');
    final Response res = await patch(
      url,
      headers: headers,
      body: encodedData,
    );
    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }
}
