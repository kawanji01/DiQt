import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalSecrets {
  // ユーザーの認証情報を取得する
  // Providerが消えてもログインを維持できるように、認証トークンはSecureStorageに保存しておく。
  static Future<String?> authToken() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    return token;
  }

  // ユーザーの認証情報を書き込む
  static Future<void> writeAuthToken(String? token) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'token', value: '$token');
  }

  static Future<void> deleteSecrets() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}
