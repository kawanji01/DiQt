import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/device_info_service.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/entity/auth_result.dart';

class RemoteSessions {
  // メール認証
  Future<Map> login(String email, String password) async {
    try {
      // デバイスの識別IDなどを取得する
      final deviceInfo = DeviceInfoService();
      final String platform = deviceInfo.getPlatform();
      final String deviceIdentifier = await deviceInfo.getIndentifier();
      final String deviceName = await deviceInfo.getName();
      final String locale = await LocalUserInfo.localeForAPI();

      final Uri url =
          Uri.parse('${DiQtURL.root(locale: locale)}/api/v1/mobile/sessions');
      final Map<String, dynamic> body = {
        'email': email,
        'password': password,
        'device_identifier': deviceIdentifier,
        'device_name': deviceName,
        'platform': platform,
      };
      final Response res = await HttpService.post(url, body);
      // エラーを検知して、エラー用のMapを返す。
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

  // 新規登録
  Future<Map> signUp(String name, String email, String password) async {
    try {
      // デバイスの識別IDなどを取得する
      final deviceInfo = DeviceInfoService();
      final String platform = deviceInfo.getPlatform();
      final String deviceIdentifier = await deviceInfo.getIndentifier();
      final String deviceName = await deviceInfo.getName();
      final String locale = await LocalUserInfo.localeForAPI();
      // リクエスト
      final Uri url =
          Uri.parse('${DiQtURL.root(locale: locale)}/api/v1/mobile/users');
      final Map<String, dynamic> body = {
        'name': name,
        'email': email,
        'password': password,
        'device_identifier': deviceIdentifier,
        'device_name': deviceName,
        'platform': platform,
      };

      final Response res = await HttpService.post(url, body);
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

  // ログアウト / sessions/logout
  Future<Map> logOut() async {
    try {
      final deviceInfo = DeviceInfoService();
      final String deviceIdentifier = await deviceInfo.getIndentifier();
      var url = Uri.parse('${DiQtURL.root()}/api/v1/mobile/sessions/logout');
      final Map<String, dynamic> body = {'device_identifier': deviceIdentifier};
      Response res = await HttpService.post(url, body);
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

  // Twitter認証
  static Future<Map?> twitter(AuthResult authResult) async {
    try {
      // デバイスの識別IDなどを取得する
      final deviceInfo = DeviceInfoService();
      final String platform = deviceInfo.getPlatform();
      final String deviceIdentifier = await deviceInfo.getIndentifier();
      final String deviceName = await deviceInfo.getName();

      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/sessions/twitter');
      final Map<String, dynamic> body = {
        'uid': '${authResult.user!.id}',
        'name': authResult.user!.name,
        'email': authResult.user!.email,
        'image': authResult.user!.thumbnailImage,
        'device_identifier': deviceIdentifier,
        'platform': platform,
        'device_name': deviceName,
      };

      final Response res = await HttpService.post(url, body);

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

  // Google認証
  static Future<Map?> google(GoogleSignInAuthentication googleAuth) async {
    try {
      ////  認証時のリクエストに含めるデバイスの識別IDなどを取得する ////
      final deviceInfo = DeviceInfoService();
      final String platform = deviceInfo.getPlatform();
      final String deviceIdentifier = await deviceInfo.getIndentifier();
      final String deviceName = await deviceInfo.getName();
      ////  認証時のリクエストに含めるデバイスの識別IDなどを取得する(END) ////

      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/sessions/google');
      final Map<String, dynamic> body = {
        'identity_token': googleAuth.idToken,
        'device_identifier': deviceIdentifier,
        'platform': platform,
        'device_name': deviceName,
      };
      final Response res = await HttpService.post(url, body);
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

  // Apple認証
  static Future<Map?> apple(
      AuthorizationCredentialAppleID appleCredential) async {
    try {
      ////  認証時のリクエストに含めるデバイスの識別IDなどを取得する ////
      final deviceInfo = DeviceInfoService();
      final String platform = deviceInfo.getPlatform();
      final String deviceIdentifier = await deviceInfo.getIndentifier();
      final String deviceName = await deviceInfo.getName();
      ////  認証時のリクエストに含めるデバイスの識別IDなどを取得する(END) ////

      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/sessions/apple');
      final Map<String, dynamic> body = {
        'identity_token': appleCredential.identityToken,
        'authorization_code': appleCredential.authorizationCode,
        'device_identifier': deviceIdentifier,
        'platform': platform,
        'device_name': deviceName,
      };
      final Response res = await HttpService.post(url, body);
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
