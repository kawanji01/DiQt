import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/data/remote/azure_speech_assessment.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/utils/sanitizer.dart';
import 'package:booqs_mobile/notifications/answer.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart';

class RemoteQuizzes {
  static final AzureSpeechAssessmentClient _azureSpeechAssessmentClient =
      AzureSpeechAssessmentClient();

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

  static Future<Map> answerPronunciation({
    required Quiz quiz,
    required File audioFile,
    String? answerType,
    AzureSpeechAssessmentClient? assessmentClient,
  }) async {
    try {
      final String? locale = _pronunciationLocale(quiz);
      final String referenceText = _primaryPronunciationReferenceText(quiz);
      if (locale == null || referenceText.isEmpty) {
        return _pronunciationUnavailableError();
      }

      final AzureSpeechAssessmentClient client =
          assessmentClient ?? _azureSpeechAssessmentClient;
      final Map<String, dynamic> pronunciationPayload =
          await client.assessPronunciation(
        audioFile: audioFile,
        locale: locale,
        referenceText: referenceText,
      );

      final Map<String, dynamic> body = <String, dynamic>{
        'answer': '',
        'pronunciation_mode': true,
        'pronunciation_payload': pronunciationPayload,
      };
      if (answerType != null && answerType.isNotEmpty) {
        body['answer_type'] = answerType;
      }

      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/quizzes/${quiz.id}/answer');
      final Response res = await HttpService.post(url, body);

      if (ErrorHandler.isErrorResponse(res)) return ErrorHandler.errorMap(res);
      final Map resMap = json.decode(res.body);
      return resMap;
    } on AzureSpeechAssessmentException catch (e) {
      return _mapPronunciationAssessmentError(e);
    } on TimeoutException catch (e, s) {
      return ErrorHandler.timeoutMap(e, s);
    } on SocketException catch (e, s) {
      return ErrorHandler.socketExceptionMap(e, s);
    } catch (e, s) {
      return ErrorHandler.exceptionMap(e, s);
    }
  }

  static String? _pronunciationLocale(Quiz quiz) {
    if (quiz.langNumberOfAnswer == languageCodeMap['en']) {
      return 'en-US';
    }
    if (quiz.langNumberOfAnswer == languageCodeMap['ja']) {
      return 'ja-JP';
    }
    return null;
  }

  static String _primaryPronunciationReferenceText(Quiz quiz) {
    final List<String> candidates = quiz.correctAnswer
        .split(';')
        .map((String answer) {
          return Sanitizer.removeDiQtLink(answer).trim();
        })
        .where((String answer) => answer.isNotEmpty)
        .toList();
    if (candidates.isEmpty) return '';

    return candidates.first;
  }

  static Map<String, dynamic> _mapPronunciationAssessmentError(
    AzureSpeechAssessmentException exception,
  ) {
    if (_isRecognitionNoResultError(exception)) {
      return _pronunciationNoResultError(status: exception.status);
    }

    final String normalizedMessage = exception.message.toLowerCase();
    if (normalizedMessage.contains('token')) {
      return _pronunciationUnavailableError(status: 401);
    }

    return _pronunciationUnavailableError(status: exception.status);
  }

  static bool _isRecognitionNoResultError(
    AzureSpeechAssessmentException exception,
  ) {
    final String normalizedMessage = exception.message.toLowerCase();
    return normalizedMessage.startsWith(
      'azure pronunciation assessment returned no recognized speech',
    );
  }

  static Map<String, dynamic> _pronunciationUnavailableError({
    int status = 422,
  }) {
    return <String, dynamic>{
      'status': status,
      'message': t.quizzes.pronunciation_unavailable,
    };
  }

  static Map<String, dynamic> _pronunciationNoResultError({
    int status = 422,
  }) {
    return <String, dynamic>{
      'status': status,
      'message': t.quizzes.pronunciation_no_result,
    };
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

  static Future<Map> update(
      {required Map params, required String comment}) async {
    try {
      final Map<String, dynamic> body = {'quiz': params, 'comment': comment};

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

  static Future<Map> generateDistractors({
    required String question,
    required String correctAnswer,
  }) async {
    try {
      final Map<String, dynamic> body = {
        'question': question,
        'correct_answer': correctAnswer,
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

  // AI解説を生成/取得する
  static Future<Map> aiExplanation(int quizId) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/quizzes/$quizId/ai_explanation');
      final Response res = await HttpService.post(url, null);

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
