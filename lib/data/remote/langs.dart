import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:booqs_mobile/utils/sanitizer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart';

class RemoteLangs {
  // Google翻訳
  static Future<Map?> googleTranslation(String original, int sourceLangNumber,
      int targetLangNumber, User user) async {
    try {
      final String sanitizedOriginal = Sanitizer.removeDiQtLink(original);

      final Map<String, dynamic> body = {
        'original': sanitizedOriginal,
        'source_lang_number': sourceLangNumber,
        'target_lang_number': targetLangNumber,
      };

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/${user.locale()}/api/v1/mobile/langs/google_translation');
      final Response res = await HttpService.post(
        url,
        body,
      );
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

  // DeepL翻訳
  static Future<Map?> deeplTranslation(String original, int sourceLangNumber,
      int targetLangNumber, User user) async {
    try {
      final String sanitizedOriginal = Sanitizer.removeDiQtLink(original);

      // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
      final Map<String, dynamic> body = {
        'original': sanitizedOriginal,
        'source_lang_number': sourceLangNumber,
        'target_lang_number': targetLangNumber,
      };

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/${user.locale()}/api/v1/mobile/langs/deepl_translation');
      final Response res = await HttpService.post(
        url,
        body,
      );
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
