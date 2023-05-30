/* import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/app_badger_service.dart';
import 'package:booqs_mobile/utils/purchase_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; */

/* class UserSetup {
  // SignInしたあとに、必要なユーザー情報をローカルストレージに保存したり、RevenueCatで認証する。
  static Future<void> signIn(User user) async {
    // サーバーへのリクエストに必要な認証トークンなどはローカルストレージに保存しておく。
    LocalUserInfo.writeAuthToken(user.authToken);
    // RevenueCatの認証 参考：https://docs.revenuecat.com/docs/user-ids#logging-back-in
    await PurchaseService.identify(user.id.toString());
  }

  // ログアウトしたときや認証用のtokenが無効だった場合にストレージをリセットしたり、RevenueCatからログアウトする。
  static Future<void> logOut(User? user) async {
    // ローカルストレージに保存したデータを削除する
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
    // ホーム画面のアプリのバッジを消す。
    await AppBadgerService.updateReviewBadge(0);
    if (user == null) return;
    // RevenueCatからもログアウトする。参照：　https://docs.revenuecat.com/docs/user-ids#logging-out
    await PurchaseService.logOut(user.id);
  }
}
 */