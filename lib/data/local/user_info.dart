import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 書き換えが気になるなどでRiverpodを利用しない場合に利用するユーザー情報
class LocalUserInfo {
  // ユーザーの認証情報を取得する
  static Future<String?> authToken() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    return token;
  }

  // ユーザーのIDを取得する
  static Future<String?> publicUid() async {
    const storage = FlutterSecureStorage();
    String? uid = await storage.read(key: 'publicUis');
    return uid;
  }
}
