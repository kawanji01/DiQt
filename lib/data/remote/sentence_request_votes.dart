import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart';

class RemoteSentenceRequestVotes {
  static Future<Map> create(
      {required int sentenceRequestId, required bool upvoted}) async {
    try {
      final Map<String, dynamic> params = {
        'sentence_request_id': sentenceRequestId,
        'upvoted': upvoted,
      };
      final Map<String, dynamic> body = {'sentence_request_vote': params};
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/sentence_request_votes');
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

  static Future<Map> destroy(int sentenceRequestVoteId) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/sentence_request_votes/$sentenceRequestVoteId');
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
