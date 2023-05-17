import 'dart:convert';

import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/sanitizer.dart';
import 'package:http/http.dart';

class RemoteLangs {
  // Google翻訳
  static Future<Map?> googleTranslation(String original, int sourceLangNumber,
      int targetLangNumber, User user) async {
    final String? token = await LocalUserInfo.authToken();
    if (token == null) return null;

    final String sanitizedOriginal = Sanitizer.removeDiQtLink(original);

    // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
    final String encodedData = json.encode({
      'original': sanitizedOriginal,
      'source_lang_number': sourceLangNumber,
      'target_lang_number': targetLangNumber,
      'token': token
    });
    final Map<String, String> headers = {'content-type': 'application/json'};

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/${user.locale()}/api/v1/mobile/langs/google_translation');
    final Response res = await post(
      url,
      headers: headers,
      body: encodedData,
    );
    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }

  // DeepL翻訳
  static Future<Map?> deeplTranslation(String original, int sourceLangNumber,
      int targetLangNumber, User user) async {
    final String? token = await LocalUserInfo.authToken();
    if (token == null) return null;

    final String sanitizedOriginal = Sanitizer.removeDiQtLink(original);

    // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
    final String encodedData = json.encode({
      'original': sanitizedOriginal,
      'source_lang_number': sourceLangNumber,
      'target_lang_number': targetLangNumber,
      'token': token
    });
    final Map<String, String> headers = {'content-type': 'application/json'};

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/${user.locale()}/api/v1/mobile/langs/deepl_translation');
    final Response res = await post(
      url,
      headers: headers,
      body: encodedData,
    );
    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }
}
