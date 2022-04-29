import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:http/http.dart';

class RemoteAnswerSettings {
  // 更新
  // 引数は、answerSetting.toJson で生成する
  static Future<Map?> update(Map<String, dynamic> params) async {
    final String? token = await LocalUserInfo.authToken();
    if (token == null) return null;

    // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
    final String encodedData =
        json.encode({'answer_setting': params, 'token': token});
    final Map<String, String> headers = {'content-type': 'application/json'};

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/answer_settings/${params['id']}');
    final Response res = await patch(
      url,
      headers: headers,
      body: encodedData,
    );
    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }
}
