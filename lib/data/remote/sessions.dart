import 'dart:convert';
import 'package:booqs_mobile/utils/device_info%20_service.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/entity/auth_result.dart';

class RemoteSessions {
  // メール認証
  static Future<Map?> login(String email, String password) async {
    try {
      // デバイスの識別IDなどを取得する
      final deviceInfo = DeviceInfoService();
      final String platform = deviceInfo.getPlatform();
      final String deviceIdentifier = await deviceInfo.getIndentifier();
      final String deviceName = await deviceInfo.getName();

      final Uri url =
          Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/sessions');
      final String encodedData = json.encode({
        'email': email,
        'password': password,
        'device_identifier': deviceIdentifier,
        'device_name': deviceName,
        'platform': platform,
      });
      final Response res = await HttpService.post(url, encodedData);
      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
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

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/sessions/twitter');
      final String encodedData = json.encode({
        'uid': '${authResult.user!.id}',
        'name': authResult.user!.name,
        'email': authResult.user!.email,
        'image': authResult.user!.thumbnailImage,
        'device_identifier': deviceIdentifier,
        'platform': platform,
        'device_name': deviceName,
      });

      final Response res = await HttpService.post(url, encodedData);

      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
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

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/sessions/google');
      final String encodedData = json.encode({
        'identity_token': googleAuth.idToken,
        'device_identifier': deviceIdentifier,
        'platform': platform,
        'device_name': deviceName,
      });
      final Response res = await HttpService.post(url, encodedData);
      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
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

      final Uri url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/sessions/apple');
      final String encodedData = json.encode({
        'identity_token': appleCredential.identityToken,
        'authorization_code': appleCredential.authorizationCode,
        'device_identifier': deviceIdentifier,
        'platform': platform,
        'device_name': deviceName,
      });
      final Response res = await HttpService.post(url, encodedData);
      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // 新規登録
  static Future<Map?> signUp(String name, String email, String password) async {
    try {
      // デバイスの識別IDなどを取得する
      final deviceInfo = DeviceInfoService();
      final String platform = deviceInfo.getPlatform();
      final String deviceIdentifier = await deviceInfo.getIndentifier();
      final String deviceName = await deviceInfo.getName();
      // リクエスト
      final Uri url =
          Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users');
      final String encodedData = json.encode({
        'name': name,
        'email': email,
        'password': password,
        'device_identifier': deviceIdentifier,
        'device_name': deviceName,
        'platform': platform,
      });

      final Response res = await HttpService.post(url, encodedData);
      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }

  // ログアウト / sessions/logout
  static Future<Map?> logout() async {
    try {
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');
      final deviceInfo = DeviceInfoService();
      final String deviceIdentifier = await deviceInfo.getIndentifier();
      var url = Uri.parse(
          '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/sessions/logout');
      final String encodedData = json
          .encode({'token': '$token', 'device_identifier': deviceIdentifier});
      Response res = await HttpService.post(url, encodedData);
      Map? resMap = json.decode(res.body);
      return resMap;
    } catch (e) {
      return null;
    }
  }
}
