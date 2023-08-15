import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart';

class RemoteQuizzes {
  // 問題を解答する / quizzes/:id/answer
  static Future<Map> answer(
      AnswerNotification notification, String answerType) async {
    try {
      final Quiz quiz = notification.quiz;

      final Map<String, dynamic> body = {
        'answer': notification.usersAnswer,
        'correct': '${notification.correct}',
        'answer_type': answerType,
      };
      // return ErrorHandler.exceptionMap('Error Test', null);

      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/quizzes/${quiz.id}/answer');
      final Response res = await HttpService.post(url, body);

      if (ErrorHandler.isErrorResponse(res)) return ErrorHandler.errorMap(res);
      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      return ErrorHandler.timeoutMap(e, s);
    } on SocketException catch (e, s) {
      return ErrorHandler.socketExceptionMap(e, s);
    } catch (e, s) {
      return ErrorHandler.exceptionMap(e, s);
    }
  }

  // 問題のソース（辞書の項目、例文）を取得する
  static Future<Map?> source(int quizId) async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/quizzes/$quizId/source');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;
      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } on SocketException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }

  // 問題の詳細を取得
  static Future<Map?> show(int quizId) async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/quizzes/$quizId');
      final Response res = await HttpService.get(url);

      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } on SocketException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }

  static Future<Map> update(Map params) async {
    try {
      final Map<String, dynamic> body = {'quiz': params};

      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/quizzes/${params['id']}');
      final Response res = await HttpService.patch(
        url,
        body,
      );
      if (ErrorHandler.isErrorResponse(res)) return ErrorHandler.errorMap(res);

      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      return ErrorHandler.timeoutMap(e, s);
    } on SocketException catch (e, s) {
      return ErrorHandler.socketExceptionMap(e, s);
    } catch (e, s) {
      return ErrorHandler.exceptionMap(e, s);
    }
  }

  static Future<Map> generateDistractors(
      {required String question,
      required String correctAnswer,
      required String model}) async {
    try {
      final Map<String, dynamic> body = {
        'question': question,
        'correct_answer': correctAnswer,
        'model': model,
      };

      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/quizzes/generate_distractors');
      final Response res = await HttpService.post(
        url,
        body,
      );
      if (ErrorHandler.isErrorResponse(res)) return ErrorHandler.errorMap(res);

      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      return ErrorHandler.timeoutMap(e, s);
    } on SocketException catch (e, s) {
      return ErrorHandler.socketExceptionMap(e, s);
    } catch (e, s) {
      return ErrorHandler.exceptionMap(e, s);
    }
  }
}
