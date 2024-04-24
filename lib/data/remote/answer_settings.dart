import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart';

class RemoteAnswerSettings {
  // 更新
  // 引数は、answerSetting.toJson で生成する
  static Future<Map> update(Map<String, dynamic> params) async {
    try {
      // 更新する必要がない＆encode errorの発生するエントリーは消しておく。
      params.removeWhere((dynamic key, dynamic value) =>
          key == 'created_at' || key == 'updated_at');

      final Map<String, dynamic> body = {'answer_setting': params};

      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/answer_settings/${params['id']}');
      final Response res = await HttpService.patch(url, body);
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

  // 演出の有効・無効を切り替える
  static Future<Map> switchEffect(int settingId) async {
    try {
      final Map<String, dynamic> body = {};
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/answer_settings/$settingId/switch_effect');
      final Response res = await HttpService.patch(url, body);
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

  // SEの有効・無効を切り替える
  static Future<Map> switchSE(int settingId) async {
    try {
      final Map<String, dynamic> body = {};
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/answer_settings/$settingId/switch_se');
      final Response res = await HttpService.patch(url, body);
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
