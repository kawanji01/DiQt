import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:http/http.dart';

class RemoteCheers {
  // 応援の作成
  static Future<Map?> create(int activityId) async {
    final String? token = await LocalUserInfo.authToken();
    if (token == null) return null;

    final Uri url =
        Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/cheers');
    final Map boby = {
      'token': token,
      'activity_id': '$activityId',
    };

    final Response res = await post(url, body: boby);
    if (res.statusCode != 200) return null;

    final Map resMap = json.decode(res.body);
    return resMap;
  }
}
