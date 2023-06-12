import 'dart:convert';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/crashlytics_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ErrorHandler {
  // レスポンスがエラーか判別する
  static bool isErrorResponse(Response res) {
    final int statusCode = res.statusCode;
    return statusCode < 200 || statusCode >= 300;
  }

  // Mapがエラーか判別する
  static bool isErrorMap(Map resMap) {
    final int statusCode = resMap['status'];
    return statusCode < 200 || statusCode >= 300;
  }

  // エラーメッセージを返す
  static String message(Map resMap, {bool useServerMessage = false}) {
    final int status = resMap['status'];
    final String message = resMap['message'] ?? '';
    final String systemMessage = t['errors.http_status_$status'];
    if (useServerMessage && message != '') {
      return message;
    }
    return systemMessage;
  }

  // エラーをスナックバーで表示する
  static void showErrorSnackBar(BuildContext context, Map resMap,
      {serverSideMessage = false}) {
    // 画面に表示されてるスナックバーを消す
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    final message =
        ErrorHandler.message(resMap, useServerMessage: serverSideMessage);
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // エラー用のmapを返す
  static Map<String, dynamic> errorMap(Response res) {
    try {
      final Map resMap = json.decode(res.body);
      return {
        'status': res.statusCode,
        'message': resMap['message'],
      };
    } catch (e) {
      return {'status': res.statusCode, 'message': '$e'};
    }
  }

  // timeout用のmapを返す
  static Map<String, dynamic> timeoutMap(
    dynamic exception,
    StackTrace? stack,
  ) {
    CrashlyticsService.recordError(exception, stack);
    return {'status': 408, 'message': '$exception'};
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
    CrashlyticsService.recordError(exception, stack);
    // 一番近いステータスコードとして、504 Gateway Timeout（リクエストを送ったサーバからの適切なレスポンスがなくタイムアウト）を返す。
    return {'status': 504, 'message': '$exception'};
  }

  // Exception用のmapを返す
  static Map<String, dynamic> exceptionMap(
    dynamic exception,
    StackTrace? stack,
  ) {
    CrashlyticsService.recordError(exception, stack);
    return {'status': 500, 'message': '$exception'};
  }
}
