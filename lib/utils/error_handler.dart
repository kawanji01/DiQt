import 'dart:convert';

import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart';

class ErrorHandler {
  // エラーメッセージを返す
  static String message(Map<String, dynamic> resMap, bool useStystemMessage) {
    final int status = resMap['status'];
    final String message = resMap['message'] ?? '';
    final String systemMessage = t['errors.http_status_$status'];
    if (useStystemMessage && message != '') {
      return message;
    }
    return systemMessage;
  }

  // エラーかどうかを判別する
  static bool isError(Response res) {
    return res.statusCode < 200 || res.statusCode >= 300;
  }

  // エラー用のmapを返す
  static Map<String, dynamic> errorMap(Response res) {
    try {
      final Map resMap = json.decode(res.body);
      return {
        'status': res.statusCode,
        'error': {'status': resMap['status'], 'message': resMap['message']}
      };
    } catch (e) {
      return {
        'status': res.statusCode,
        'error': {'status': res.statusCode},
      };
    }
  }

  // timeout用のmapを返す
  static Map<String, dynamic> timeoutMap(
    dynamic exception,
    StackTrace? stack,
  ) {
    FirebaseCrashlytics.instance.recordError(exception, stack);
    return {
      'status': 408,
      'error': {'status': 408},
    };
  }

  // socketExcecptionのmap
  // SocketExceptionは、Flutter（というよりもDart言語自体）でネットワーク接続に問題が発生したときに投げられる例外。
  // 一般的に、SocketExceptionは以下のような原因で発生します：
  // ・ネットワークが接続されていないか、接続が非常に不安定である
  // ・接続しようとしたサーバーがダウンしているか、その他の理由で接続を拒否している
  // ・ファイアウォールやセキュリティソフトウェアが接続をブロックしている
  // HTTPのステータスコードとは異なり、SocketExceptionは通信自体がうまく行かなかったことを示すものであり、特定のHTTPステータスコードとは関連付けられていません。
  static Map<String, dynamic> socketExceptionMap(
    dynamic exception,
    StackTrace? stack,
  ) {
    FirebaseCrashlytics.instance.recordError(exception, stack);
    // 一番近いステータスコードとして、504 Gateway Timeout（リクエストを送ったサーバからの適切なレスポンスがなくタイムアウト）を返す。
    return {
      'status': 504,
      'error': {'status': 504},
    };
  }

  // Exception用のmapを返す
  static Map<String, dynamic> exceptionMap(
    dynamic exception,
    StackTrace? stack,
  ) {
    FirebaseCrashlytics.instance.recordError(exception, stack);
    return {
      'status': 500,
      'error': {'status': 500},
    };
  }
}
