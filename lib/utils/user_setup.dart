import 'package:booqs_mobile/services/purchase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSetup {
  // SignInしたあとに、必要なユーザー情報をローカルストレージに保存したり、RevenueCatで認証する。
  static Future<void> signIn(Map resMap) async {
    final user = resMap['user'];
    if (user == null) return;
    const storage = FlutterSecureStorage();
    await storage.write(key: 'publicUid', value: user['public_uid']);
    await storage.write(key: 'premium', value: user['premium'].toString());
    await storage.write(key: 'token', value: user['token_for_native_app']);
    await storage.write(
        key: 'remindersCount', value: user['reminders_count'].toString());
    await storage.write(
        key: 'notificationsCount',
        value: user['notifications_count'].toString());

    // RevenueCatの認証 参考：https://docs.revenuecat.com/docs/user-ids#logging-back-in
    await PurchaseService.identify(user['id'].toString());
  }

  // ログアウトしたときや認証用のtokenが無効だった場合にストレージをリセットしたり、RevenueCatからログアウトする。
  static Future<void> logOut() async {
    // RevenueCatからもログアウトする。参照：　https://docs.revenuecat.com/docs/user-ids#logging-out
    // String? userUid = await storage.read(key: 'public_uid');
    // await Purchases.logOut();
    // トークンをローカルストレージから削除
    const storage = FlutterSecureStorage();
    await PurchaseService.logOut();
    await storage.deleteAll();
  }
}
