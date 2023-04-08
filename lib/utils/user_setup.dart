import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/purchase_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSetup {
  // SignInしたあとに、必要なユーザー情報をローカルストレージに保存したり、RevenueCatで認証する。
  static Future<void> signIn(User user) async {
    // Providerが利用できないサービスクラスでも利用できるように、
    // サーバーへのリクエストに必要なパラメーターなどはローカルストレージに保存しておく。
    const storage = FlutterSecureStorage();
    await storage.write(key: 'token', value: user.authToken);
    await storage.write(key: 'publicUid', value: user.publicUid);
    await storage.write(key: 'premium', value: user.premium.toString());
    // RevenueCatの認証 参考：https://docs.revenuecat.com/docs/user-ids#logging-back-in
    await PurchaseService.identify(user.id.toString());
  }

  // ログアウトしたときや認証用のtokenが無効だった場合にストレージをリセットしたり、RevenueCatからログアウトする。
  static Future<void> logOut(User? user) async {
    // RevenueCatからもログアウトする。参照：　https://docs.revenuecat.com/docs/user-ids#logging-out
    // String? userUid = await storage.read(key: 'public_uid');
    // await Purchases.logOut();
    // トークンをローカルストレージから削除
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
    if (user == null) return;
    await PurchaseService.logOut(user.id);
  }
}
