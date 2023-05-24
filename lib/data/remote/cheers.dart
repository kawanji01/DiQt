import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart';

class RemoteCheers {
  // 応援の作成
  static Future<Map?> create(int activityId) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final Uri url =
          Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/cheers');

      final String encodedData = json.encode({
        'token': token,
        'activity_id': '$activityId',
      });

      final Response res = await HttpService.post(url, encodedData);
      if (res.statusCode != 200) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }
}
