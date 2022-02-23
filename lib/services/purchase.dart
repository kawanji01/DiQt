import 'dart:convert';
import 'dart:io' show Platform;
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:http/http.dart' as http;

// RevenueCatのセットアップ
// 参照： https://docs.revenuecat.com/docs/getting-started-1#section-configure-purchases
class PurchaseService {
  // 処理実行中にコールバック（_purchaserInfoUpdated）を実行しないための処理
  bool isExecuting = false;

  // RevenueCatの初期化するメソッド（呼んだ回数分コールバックが呼ばれるようになるのでMainで１度だけ実行する）。 参照：https://docs.revenuecat.com/docs/getting-started#7-configure-the-purchases-sdk
  Future<void> initPlatformState() async {
    // デバック用のログを表示する
    // await Purchases.setDebugLogsEnabled(true);

    if (Platform.isAndroid) {
      final publicAndroidSdkKey = dotenv.env['REVENUECAT_ANDROID_PUBLIC_KEY'];
      await Purchases.setup('$publicAndroidSdkKey');
    } else if (Platform.isIOS) {
      final publicIosSdkKey = dotenv.env['REVENUECAT_IOS_PUBLIC_KEY'];
      await Purchases.setup('$publicIosSdkKey');
    }

    // コールバック時に実行し、契約状況を同期する。
    Future<void> _purchaserInfoUpdated(PurchaserInfo info) async {
      print('purchaserInfoUpdated: $isExecuting');
      if (isExecuting) return;
      print('purchaserInfoUpdated: $info');
      await syncSubscription(info);
    }

    // 解約時のイベントを捕捉するリスナー ref: ??
    Purchases.removePurchaserInfoUpdateListener(_purchaserInfoUpdated);
    // 契約情報更新時のイベントを捕捉するリスナー ref: https://docs.revenuecat.com/docs/purchaserinfo#listening-for-purchaser-info-updates
    Purchases.addPurchaserInfoUpdateListener(_purchaserInfoUpdated);
  }

  // RevenueCatのユーザー認証。UserSetupで利用 参考：https://docs.revenuecat.com/docs/user-ids#logging-back-in
  // （利用場所を検索しやすいように独自にプロパティを用意した。識別子には、public_uidを将来的にユーザーが変更できるようにする可能性も考慮して、インクリメンタルなIDを利用した。）
  static Future<void> identify(String userId) async {
    await Purchases.logIn(userId);
  }

  static Future<void> logOut() async {
    try {
      Purchases.logOut();
    } catch (e) {
      print('error: $e');
    }
  }

  // プレミアムプランのIDを取得。
  Future<String?> fetchProductID() async {
    Offerings offerings = await Purchases.getOfferings();
    final product = offerings.current!.monthly!.product;
    return product.identifier;
  }

  // 購入処理。
  // 購入が完了したらtrueを返す。購入がキャンセルされるかDB側の同期が失敗したらfalseを返す。
  Future<bool> subscribe(String productID) async {
    try {
      isExecuting = true;
      // 購入処理
      final info = await Purchases.purchaseProduct(productID);
      // パスワードの入力の不要なキャッシュから購入（Vending PurchaserInfo from cache.）された場合、
      // isActive: falseのinfoが引き渡されることによって、
      // syncSubscription(info)内のinfo.entitlements.active.isNotEmptyをすり抜けて、契約処理ではなく、解約処理が実行されてしまう。
      // そのため、あらかじめ購入とわかっている場合には、syncSubscriptionではなく、getOrCreateSubscriberを使う。
      // final isSubscribed = await syncSubscription(info);
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');
      final isSubscribed = await getOrCreateSubscriber(token);
      isExecuting = false;
      return isSubscribed;
    } catch (e) {
      // TODO: エラーハンドリング
      print('.subscribe: $e');
      isExecuting = false;
      return false;
    }
  }

  // 同期処理。
  // PurchaserInfo（購入情報）を引数にして、ユーザーの購入状況（契約中か解約済か）をDB側で同期する。
  Future<bool> syncSubscription(PurchaserInfo info) async {
    isExecuting = true;
    bool isSubscribed = false;

    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    // ログインしてない（トークンがない）ならそもそもリクエストを飛ばさない。
    if (token == null) {
      isExecuting = false;
      print(".syncSubscription: token not found");
      return isSubscribed;
    }
    // DBの購入状況を同期する。
    // if文は１つでもプレミアムプランがアクティブなら、trueを返す処理 ref: https://docs.revenuecat.com/docs/purchaserinfo#checking-if-a-user-is-subscribed
    // 現状はプランによって提供機能を変えていないためこれで十分
    if (info.entitlements.active.isNotEmpty) {
      print(".syncSubscription: NotEmpty / 購入する");
      isSubscribed = await getOrCreateSubscriber(token);
    } else {
      print(".syncSubscription: Empty / 解約する");
      isSubscribed = await deleteSubscriber(token);
    }
    return isSubscribed;
  }

  // DB側の契約処理
  // サーバー側でユーザーの契約しているサブスクを取得するか、なければ契約して、契約をDBと同期する。 ref: https://docs.revenuecat.com/reference/subscribers
  Future<bool> getOrCreateSubscriber(token) async {
    String? platform;
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/api/v1/mobile/users/get_or_create_subscriber');
    var res =
        await http.post(url, body: {'token': token, 'platform': platform});
    print('.getOrCreateSubscriber: response ${res.statusCode}');
    if (res.statusCode != 200) {
      return false;
    }

    Map resMap = json.decode(res.body);
    print('.getOrCreateSubscriber: ${resMap['message']}');
    await UserSetup.signIn(resMap);
    return true;
  }

  // DB側の解約処理
  // サーバー側でSubscriptionを削除して、解約をDBと同期する。
  Future<bool> deleteSubscriber(token) async {
    String? platform;
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/api/v1/mobile/users/delete_subscriber');
    var res =
        await http.post(url, body: {'token': token, 'platform': platform});
    print('.deleteSubscriber: response ${res.statusCode}');
    if (res.statusCode != 200) {
      return false;
    }

    Map resMap = json.decode(res.body);
    print('.deleteSubscriber: ${resMap['message']}');
    await UserSetup.signIn(resMap);
    return true;
  }

  // リストア処理。ref: https://docs.revenuecat.com/docs/restoring-purchases
  Future<bool> restore() async {
    try {
      print('.retore');
      PurchaserInfo restoredInfo = await Purchases.restoreTransactions();
      // リストアできる購入情報が存在しなければ、falseを返す。
      // if文はアクティブなサブスクが一つもなければtrueを返す処理 ref:  https://docs.revenuecat.com/docs/purchaserinfo#checking-if-a-user-is-subscribed
      if (restoredInfo.entitlements.active.isEmpty) return false;
      bool result = await syncSubscription(restoredInfo);
      return result;
    } on PlatformException catch (e) {
      print('.restore: $e');
      return false;
    }
  }
}
