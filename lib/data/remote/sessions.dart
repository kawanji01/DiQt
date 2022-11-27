import 'dart:convert';
import 'package:booqs_mobile/services/device_info.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/entity/auth_result.dart';

class RemoteSessions {
  // メール認証
  static Future<Map?> login(String email, String password) async {
    // デバイスの識別IDなどを取得する
    final deviceInfo = DeviceInfoService();
    final String platform = deviceInfo.getPlatform();
    final String deviceIdentifier = await deviceInfo.getIndentifier();
    final String deviceName = await deviceInfo.getName();

    final Uri url =
        Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/sessions');
    final Response res = await post(url, body: {
      'email': email,
      'password': password,
      'device_identifier': deviceIdentifier,
      'device_name': deviceName,
      'platform': platform,
    });
    if (res.statusCode != 200) return null;

    Map? resMap = json.decode(res.body);
    return resMap;
  }

  // Twitter認証
  static Future<Map?> twitter(AuthResult authResult) async {
    // デバイスの識別IDなどを取得する
    final deviceInfo = DeviceInfoService();
    final String platform = deviceInfo.getPlatform();
    final String deviceIdentifier = await deviceInfo.getIndentifier();
    final String deviceName = await deviceInfo.getName();

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/sessions/twitter');
    final Response res = await post(url, body: {
      'uid': '${authResult.user!.id}',
      'name': authResult.user!.name,
      'email': authResult.user!.email,
      'image': authResult.user!.thumbnailImage,
      'device_identifier': deviceIdentifier,
      'platform': platform,
      'device_name': deviceName,
    });

    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }

  // Google認証
  static Future<Map?> google(GoogleSignInAuthentication googleAuth) async {
    ////  認証時のリクエストに含めるデバイスの識別IDなどを取得する ////
    final deviceInfo = DeviceInfoService();
    final String platform = deviceInfo.getPlatform();
    final String deviceIdentifier = await deviceInfo.getIndentifier();
    final String deviceName = await deviceInfo.getName();
    ////  認証時のリクエストに含めるデバイスの識別IDなどを取得する(END) ////

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/sessions/google');
    final Response res = await post(url, body: {
      'identity_token': googleAuth.idToken,
      'device_identifier': deviceIdentifier,
      'platform': platform,
      'device_name': deviceName,
    });
    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }

  // Apple認証
  static Future<Map?> apple(
      AuthorizationCredentialAppleID appleCredential) async {
    ////  認証時のリクエストに含めるデバイスの識別IDなどを取得する ////
    final deviceInfo = DeviceInfoService();
    final String platform = deviceInfo.getPlatform();
    final String deviceIdentifier = await deviceInfo.getIndentifier();
    final String deviceName = await deviceInfo.getName();
    ////  認証時のリクエストに含めるデバイスの識別IDなどを取得する(END) ////

    final Uri url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/sessions/apple');
    final Response res = await post(url, body: {
      'identity_token': appleCredential.identityToken,
      'authorization_code': appleCredential.authorizationCode,
      'device_identifier': deviceIdentifier,
      'platform': platform,
      'device_name': deviceName,
    });
    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }

  // 新規登録
  static Future<Map?> signUp(String name, String email, String password) async {
    // デバイスの識別IDなどを取得する
    final deviceInfo = DeviceInfoService();
    String platform = deviceInfo.getPlatform();
    String deviceIdentifier = await deviceInfo.getIndentifier();
    String deviceName = await deviceInfo.getName();
    // リクエスト
    Uri url = Uri.parse('${DiQtURL.rootWithoutLocale()}/api/v1/mobile/users');
    Response res = await post(url, body: {
      'name': name,
      'email': email,
      'password': password,
      'device_identifier': deviceIdentifier,
      'device_name': deviceName,
      'platform': platform,
    });
    if (res.statusCode != 200) return null;

    final Map? resMap = json.decode(res.body);
    return resMap;
  }

  // ログアウト / sessions/logout
  static Future<Map?> logout() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    final deviceInfo = DeviceInfoService();
    final String deviceIdentifier = await deviceInfo.getIndentifier();
    var url = Uri.parse(
        '${DiQtURL.rootWithoutLocale()}/api/v1/mobile/sessions/logout');
    Response res = await post(url,
        body: {'token': '$token', 'device_identifier': deviceIdentifier});
    Map? resMap = json.decode(res.body);
    return resMap;
  }
}
