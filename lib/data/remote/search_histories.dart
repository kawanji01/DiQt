import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart';

class RemoteSearchHistories {
  static Future<Map> index(
      int pageKey, int pageSize, String order, String deviceType) async {
    try {
      final Uri url = Uri.parse(
          '${DiQtURL.root()}/api/v1/mobile/search_histories?order=$order&page=$pageKey&size=$pageSize&device_type=$deviceType');
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
