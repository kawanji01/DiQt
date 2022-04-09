import 'package:booqs_mobile/data/provider/answer_setting_provider.dart';
import 'package:booqs_mobile/data/provider/current_exp_provider.dart';
import 'package:booqs_mobile/data/provider/logged_in_user_provider.dart';
import 'package:booqs_mobile/models/answer_setting.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/services/purchase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSetup {
  // SignInしたあとに、必要なユーザー情報をローカルストレージに保存したり、RevenueCatで認証する。
  static Future<void> signIn(Map resMap) async {
    if (resMap['user'] == null) return;

    final User user = User.fromJson(resMap['user']);
    final AnswerSetting answerSetting = user.answerSetting!;

    const storage = FlutterSecureStorage();
    await storage.write(key: 'token', value: user.authToken);

    await storage.write(key: 'publicUid', value: user.publicUid);
    await storage.write(key: 'premium', value: user.premium.toString());
    await storage.write(
        key: 'unsolvedReviewsCount',
        value: user.unsolvedReviewsCount.toString());
    await storage.write(
        key: 'unreadNotificationsCount',
        value: user.unreadNotificationsCount.toString());

    // ログインユーザーの情報を更新する
    //print('userSetup');
    /* StateProvider((ref) {
      print('userSetup:Provider');
      ref.read(currentExpProvider.notifier).state = user.amountOfExp;
      ref.read(loggedInUserProvider.notifier).state = user;
      ref.read(answerSettingProvider.notifier).state = answerSetting;
      return ref.watch(currentExpProvider);
    }); */

    // RevenueCatの認証 参考：https://docs.revenuecat.com/docs/user-ids#logging-back-in
    await PurchaseService.identify(user.id.toString());
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
    Provider((ref) {
      //ref.read(currentExpProvider.notifier).state = 0;
    });
  }
}
