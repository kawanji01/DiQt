import 'dart:convert';
import 'dart:io' show Platform;
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:http/http.dart' as http;

// RevenueCatのセットアップ
// ref： https://docs.revenuecat.com/docs/getting-started-1#section-configure-purchases
class PurchaseService {
  // 処理実行中にコールバック（_purchaserInfoUpdated）を実行しないための処理
  bool isExecuting = false;

  // RevenueCatの初期化するメソッド（呼んだ回数分コールバックが呼ばれるようになるのでMainで１度だけ実行する）。 ref：https://docs.revenuecat.com/docs/getting-started#7-configure-the-purchases-sdk
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

    // アプリ起動時などのコールバック時に実行され、契約状況をDBと同期する。
    Future<void> _purchaserInfoUpdated(PurchaserInfo info) async {
      //print('purchaserInfoUpdated: $isExecuting');
      //print('_purchaserInfoUpdated: ${info.entitlements}');
      if (isExecuting) return;
      await syncSubscription(info);
    }

    // 契約情報更新時のイベントを捕捉するリスナー ref: https://docs.revenuecat.com/docs/purchaserinfo#listening-for-purchaser-info-updates
    Purchases.addPurchaserInfoUpdateListener(_purchaserInfoUpdated);
  }

  // RevenueCatのユーザー認証。UserSetupで利用 　ref：https://docs.revenuecat.com/docs/user-ids#logging-back-in
  // （利用場所を検索しやすいように独自にプロパティを用意した。識別子には、public_uidを将来的にユーザーが変更できるようにする可能性も考慮して、インクリメンタルなIDを利用した。）
  static Future<void> identify(String userId) async {
    await Purchases.logIn(userId);
  }

  static Future<void> logOut(int id) async {
    try {
      Purchases.logOut();
    } catch (e) {
      //print('error: $e');
      rethrow;
    }
  }

  // プレミアムプランのIDを取得。
  Future<String> fetchProductID() async {
    Offerings offerings = await Purchases.getOfferings();
    final product = offerings.current!.monthly!.product;
    return product.identifier;
  }

  // 購入処理
  // 購入が完了したらtrueを返す。購入がキャンセルされるか、DBの同期が失敗したらfalseを返す。
  Future<bool> subscribe(String productID) async {
    try {
      isExecuting = true;
      // クライアント側の購入処理
      await Purchases.purchaseProduct(productID);
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');
      // DB側の購入情報の同期
      // パスワードの入力の不要なキャッシュから購入（Vending PurchaserInfo from cache.）された場合、
      // syncSubscription(info)で契約処理を行なってしまうと、isActive: falseのinfoが引き渡されることによって、
      // syncSubscription(info)内のinfo.entitlements.active.isNotEmptyをすり抜けて、契約処理ではなく、解約処理が実行されてしまう。
      // そのため、あらかじめ購入とわかっている場合には、同期にはsyncSubscriptionではなく、getOrCreateSubscriberを使う。
      final isSubscribed = await getOrCreateSubscriber(token);
      return isSubscribed;
    } catch (e) {
      // print('.subscribe: $e');
      return false;
    } finally {
      // errorであれreturnで外部コードに抜ける前であれ、常に実行する。ref: https://ja.javascript.info/try-catch#ref-1685
      isExecuting = false;
    }
  }

  // DBの同期処理
  // restoreや_purchaserInfoUpdated（コールバック）で利用
  // PurchaserInfo（購入情報）を引数にして、ユーザーの購入状況（契約中か解約済か）をDB側で同期する。
  Future<bool> syncSubscription(PurchaserInfo info) async {
    isExecuting = true;
    bool isSubscribed = false;
    // print('syncSubscription: ${info.entitlements}');

    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    // ログインしてない（トークンがない）ならそもそもリクエストを飛ばさない。
    if (token == null) {
      isExecuting = false;
      // print(".syncSubscription: token not found");
      return isSubscribed;
    }
    // DBの購入状況を同期する。
    // if文は１つでもプレミアムプランがアクティブなら、trueを返す処理 ref: https://docs.revenuecat.com/docs/purchaserinfo#checking-if-a-user-is-subscribed
    // 現状はプランによって提供機能を変えていないためこれで十分
    if (info.entitlements.active.isNotEmpty) {
      // print(".syncSubscription: NotEmpty / 購入する");
      isSubscribed = await getOrCreateSubscriber(token);
    } else {
      // print(".syncSubscription: Empty / 解約する");
      isSubscribed = await deleteSubscriber(token);
    }
    isExecuting = false;
    return isSubscribed;
  }

  // DB側の購入処理（DBとの同期）
  // クライアント側で購入を行なっているので、これはDB側の購入の同期処理。
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

    if (res.statusCode != 200) {
      // print('.getOrCreateSubscriber: response ${res.statusCode}');
      return false;
    }

    Map resMap = json.decode(res.body);
    User user = User.fromJson(resMap['user']);
    await UserSetup.signIn(user);
    return true;
  }

  // DB側の解約処理
  // クライアント側に解約APIは用意されていないので、サーバー側（Ruby）の解約APIを叩き、解約をDBと同期する。
  Future<bool> deleteSubscriber(token) async {
    final url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/api/v1/mobile/users/delete_subscriber');
    final res = await http.post(url, body: {'token': token});

    if (res.statusCode != 200) {
      return false;
    }

    final Map resMap = json.decode(res.body);
    final User user = User.fromJson(resMap['user']);
    await UserSetup.signIn(user);
    return true;
  }

  // リストア処理 ref: https://docs.revenuecat.com/docs/restoring-purchases
  Future<bool> restore() async {
    try {
      isExecuting = true;
      PurchaserInfo restoredInfo = await Purchases.restoreTransactions();
      // リストアできる購入情報が存在しなければ、falseを返す。
      // if文はアクティブなサブスクが一つもなければtrueを返す処理 ref:  https://docs.revenuecat.com/docs/purchaserinfo#checking-if-a-user-is-subscribed
      if (restoredInfo.entitlements.active.isEmpty) return false;
      bool result = await syncSubscription(restoredInfo);
      return result;
    } on PlatformException catch (e) {
      print('.restore: $e');
      return false;
    } finally {
      isExecuting = false;
    }
  }
}
