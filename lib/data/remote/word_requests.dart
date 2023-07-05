import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart';

class RemoteWordRequests {
  static Future<Map> listForDictionary(
      {required int dictionaryId,
      required String type,
      required int pageKey,
      required int pageSize}) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/word_requests/list_for_dictionary?dictionary_id=$dictionaryId&type=$type&page=$pageKey&size=$pageSize');
      final Response res = await HttpService.get(url);
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