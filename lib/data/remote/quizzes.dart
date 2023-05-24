import 'dart:convert';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class RemoteQuizzes {
  // 問題を解答する / quizzes/:id/answer
  static Future<Map?> answer(
      AnswerNotification notification, String answerType) async {
    try {
      final Quiz quiz = notification.quiz;

      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: 'token');
      if (token == null) return null;

      final String encodedData = json.encode({
        'token': token,
        'answer': notification.usersAnswer,
        'correct': '${notification.correct}',
        'answer_type': answerType,
      });

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/quizzes/${quiz.id}/answer');
      final Response res = await HttpService.post(url, encodedData);

      if (res.statusCode != 200) return null;
      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 問題のソース（辞書の項目、例文）を取得する
  static Future<Map?> source(int quizId) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/quizzes/$quizId/source?token=$token');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;
      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 問題の詳細を取得
  static Future<Map?> show(int quizId) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/quizzes/$quizId?token=$token');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> edit(int quizId) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/quizzes/$quizId/edit?token=$token');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> update(Map params) async {
    try {
      final String? token = await LocalUserInfo.authToken();

      // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
      final String encodedData =
          json.encode({'quiz': params, 'token': '$token'});

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/quizzes/${params['id']}');
      final Response res = await HttpService.patch(
        url,
        encodedData,
      );
      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }
}
