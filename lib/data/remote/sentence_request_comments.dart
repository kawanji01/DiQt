import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart';

import '../../utils/error_handler.dart';

class RemoteSentenceRequestComments {
  static Future<Map> create(
      {required int sentenceRequestId,
      required String text,
      required int? appliedDictionaryId}) async {
    try {
      final Map<String, dynamic> params = {
        'sentence_request_id': sentenceRequestId,
        'body': text,
        'applied_dictionary_id': appliedDictionaryId,
      };
      final Map<String, dynamic> body = {'sentence_request_comment': params};
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/sentence_request_comments');
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

  static Future<Map> update({
    required int sentenceRequestCommentId,
    required String text,
  }) async {
    try {
      final Map<String, dynamic> params = {
        'body': text,
      };
      final Map<String, dynamic> body = {'sentence_request_comment': params};
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/sentence_request_comments/$sentenceRequestCommentId');
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

  static Future<Map> destroy(int sentenceRequestCommentId) async {
    try {
      print('sentenceRequestCommentId: $sentenceRequestCommentId');
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/sentence_request_comments/$sentenceRequestCommentId');
      final Response res = await HttpService.delete(url, null);
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
