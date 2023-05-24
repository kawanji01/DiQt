import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:http/http.dart';

class RemoteAchievementMaps {
  static Future<Map?> update(int achievementMapId) async {
    try {
      final String? token = await LocalUserInfo.authToken();
      if (token == null) return null;

      final String encodedData = json.encode({'token': token});
      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/achievement_maps/$achievementMapId');
      final Response res = await HttpService.patch(url, encodedData);
      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }
}
