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

  // AI検索（ストリーミング）
  static Stream<String> aiSearchStream(
      {required String keyword,
      required int sourceLangNumber,
      required int targetLangNumber,
      required String promptKey,
      int version = 4,
      String? model}) {
    late StreamController<String> controller;
    final Client client = Client();
    StreamSubscription<String>? subscription;
    bool isClosed = false;

    void closeStream() {
      if (isClosed) return;
      isClosed = true;
      if (subscription != null) {
        unawaited(subscription!.cancel());
      }
      client.close();
      if (!controller.isClosed) {
        unawaited(controller.close());
      }
    }

    controller = StreamController<String>(onCancel: closeStream);

    () async {
      try {
        final String sanitizedKeyword = Sanitizer.removeDiQtLink(keyword);
        final Map<String, dynamic> body = {
          'keyword': sanitizedKeyword,
          'source_lang_number': sourceLangNumber,
          'target_lang_number': targetLangNumber,
          'prompt_key': promptKey,
          'version': version,
          'streaming': 1,
        };
        if (model != null && model.isNotEmpty) {
          body['model'] = model;
        }

        final Uri url =
            Uri.parse('${DiQtURL.root()}/api/v1/mobile/langs/ai_search');
        final Request request = Request('POST', url);
        final Map<String, String> headers = await HttpService.headers();
        headers['Accept'] = 'text/event-stream';
        request.headers.addAll(headers);
        request.body = json.encode(body);

        final StreamedResponse streamedResponse = await client.send(request);
        if (streamedResponse.statusCode < 200 ||
            streamedResponse.statusCode >= 300) {
          final String errorBody =
              await streamedResponse.stream.bytesToString();
          final Response res =
              Response(errorBody, streamedResponse.statusCode);
          if (!controller.isClosed) {
            controller.addError(ErrorHandler.errorMap(res));
          }
          closeStream();
          return;
        }

        final Stream<String> lines = streamedResponse.stream
            .transform(utf8.decoder)
            .transform(const LineSplitter());

        subscription = lines.listen((String line) {
          if (!line.startsWith('data:')) return;
          final String payload = line.substring(5).trimLeft();
          if (payload.isEmpty) return;
          Map<String, dynamic> decoded;
          try {
            decoded = json.decode(payload);
          } catch (e, s) {
            if (!controller.isClosed) {
              controller.addError(ErrorHandler.exceptionMap(e, s));
            }
            closeStream();
            return;
          }
          final String delta = decoded['delta']?.toString() ?? '';
          if (delta.isEmpty) return;
          if (delta == '[DONE]') {
            closeStream();
            return;
          }
          if (!controller.isClosed) {
            controller.add(delta);
          }
        }, onError: (Object error, StackTrace stack) {
          if (!controller.isClosed) {
            controller.addError(ErrorHandler.exceptionMap(error, stack));
          }
          closeStream();
        }, onDone: closeStream);
      } on TimeoutException catch (e, s) {
        if (!controller.isClosed) {
          controller.addError(ErrorHandler.timeoutMap(e, s));
        }
        closeStream();
      } on SocketException catch (e, s) {
        if (!controller.isClosed) {
          controller.addError(ErrorHandler.socketExceptionMap(e, s));
        }
        closeStream();
      } catch (e, s) {
        if (!controller.isClosed) {
          controller.addError(ErrorHandler.exceptionMap(e, s));
        }
        closeStream();
      }
    }();

    return controller.stream;
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
