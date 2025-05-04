import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:booqs_mobile/utils/sanitizer.dart';
import 'package:http/http.dart';

class RemoteLangs {
  // Google翻訳
  static Future<Map?> googleTranslation(
      {required String original,
      required int sourceLangNumber,
      required int targetLangNumber}) async {
    try {
      final String sanitizedOriginal = Sanitizer.removeDiQtLink(original);

      final Map<String, dynamic> body = {
        'original': sanitizedOriginal,
        'source_lang_number': sourceLangNumber,
        'target_lang_number': targetLangNumber,
      };

      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/langs/google_translation');
      final Response res = await HttpService.post(
        url,
        body,
      );
      if (ErrorHandler.isErrorResponse(res)) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException {
      return null;
    } on SocketException {
      return null;
    } catch (e) {
      return null;
    }
  }

  // DeepL翻訳
  static Future<Map?> deeplTranslation(
      {required String original,
      required int sourceLangNumber,
      required int targetLangNumber}) async {
    try {
      final String sanitizedOriginal = Sanitizer.removeDiQtLink(original);

      // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
      final Map<String, dynamic> body = {
        'original': sanitizedOriginal,
        'source_lang_number': sourceLangNumber,
        'target_lang_number': targetLangNumber,
      };

      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/langs/deepl_translation');
      final Response res = await HttpService.post(
        url,
        body,
      );
      if (ErrorHandler.isErrorResponse(res)) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException {
      return null;
    } on SocketException {
      return null;
    } catch (e) {
      return null;
    }
  }

  // 形態素解析による分かち書き
  static Future<Map> wordSegmentation(
      {required String keyword, required int langNumber}) async {
    try {
      final String sanitizedKeyword = Sanitizer.removeDiQtLink(keyword);

      // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
      final Map<String, dynamic> body = {
        'keyword': sanitizedKeyword,
        'lang_number': langNumber,
      };

      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/langs/word_segmentation');
      final Response res = await HttpService.post(
        url,
        body,
      );
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

  // AI検索
  static Future<Map> aiSearch(
      {required String keyword,
      required int sourceLangNumber,
      required int targetLangNumber,
      required String promptKey,
      required int version}) async {
    try {
      final String sanitizedKeyword = Sanitizer.removeDiQtLink(keyword);
      // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
      final Map<String, dynamic> body = {
        'keyword': sanitizedKeyword,
        'source_lang_number': sourceLangNumber,
        'target_lang_number': targetLangNumber,
        'prompt_key': promptKey,
        'version': version,
      };

      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/langs/ai_search');
      final Response res = await HttpService.post(
        url,
        body,
      );
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

  // SSMLのテンプレートを取得する
  static Future<Map?> getSsmlTemplate(
      {required String langCode, required String text}) async {
    try {
      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/langs/ssml_template');
      final Map<String, dynamic> params = {
        'lang_code': langCode,
        'text': text,
      };
      final Response res = await HttpService.post(url, params);
      if (ErrorHandler.isErrorResponse(res)) return ErrorHandler.errorMap(res);
      final Map resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      print('getSsmlTemplate error: $e');
      return null;
    }
  }
}
