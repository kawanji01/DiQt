import 'package:booqs_mobile/utils/revenue_cat.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSetup {
  // SignInしたあとに、必要なユーザー情報をローカルストレージに保存したり、RevenueCatで認証する。
  static Future<void> signIn(Map resMap) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'publicUid', value: resMap['user']['public_uid']);
    await storage.write(key: 'token', value: resMap['token']);
    await storage.write(
        key: 'remindersCount', value: resMap['reminders_count'].toString());
    await storage.write(
        key: 'notificationsCount',
        value: resMap['notifications_count'].toString());

    // RevenueCatの認証 参考：https://docs.revenuecat.com/docs/user-ids#logging-back-in
    await RevenueCat.identify(resMap['user']['id']);
  }

  // ログアウトしたときや認証用のtokenが無効だった場合にストレージをリセットしたり、RevenueCatからログアウトする。
  static Future<void> logOut() async {
    // RevenueCatからもログアウトする。参照：　https://docs.revenuecat.com/docs/user-ids#logging-out
    // String? userUid = await storage.read(key: 'public_uid');
    // await Purchases.logOut();
    // トークンをローカルストレージから削除
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}
