import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart';

class RemoteAnswerSettings {
  // 更新
  // 引数は、answerSetting.toJson で生成する
  static Future<Map?> update(Map<String, dynamic> params) async {
    try {
      // 更新する必要がない＆encode errorの発生するエントリーは消しておく。
      params.removeWhere((dynamic key, dynamic value) =>
          key == 'created_at' || key == 'updated_at');

      // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
      final Map<String, dynamic> body = {'answer_setting': params};

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/answer_settings/${params['id']}');
      final Response res = await HttpService.patch(url, body);
      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
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
}
