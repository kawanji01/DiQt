import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:http/http.dart' as http;

// RevenueCatのセットアップ
// 参照： https://docs.revenuecat.com/docs/getting-started-1#section-configure-purchases
class RevenueCat {
  // 処理実行中にコールバック（_purchaserInfoUpdated）を実行しないための処理
  bool isExecuting = false;

  // RevenueCatの初期化するメソッド（呼んだ回数分コールバックが呼ばれるようになるのでMainで１度だけ実行する）。 参照：https://docs.revenuecat.com/docs/getting-started#7-configure-the-purchases-sdk
  Future<void> initPlatformState() async {
    // デバック用のログを表示する
    await Purchases.setDebugLogsEnabled(true);

    if (Platform.isAndroid) {
      // await Purchases.setup("public_google_sdk_key");
    } else if (Platform.isIOS) {
      final publicIosSdkKey = dotenv.env['REVENUECAT_IOS_PUBLIC_KEY'];
      await Purchases.setup('$publicIosSdkKey');
    }

    // リスナーがイベントを捕捉したときにログを吐き出す。
    Future<void> _purchaserInfoUpdated(PurchaserInfo info) async {
      if (isExecuting) return;
      print('purchaserInfoUpdated: $info');
      await syncSubscription(info);
    }

    // 解約時のイベントを捕捉するリスナー
    Purchases.removePurchaserInfoUpdateListener(_purchaserInfoUpdated);
    // 契約時のイベントを捕捉するリスナー
    Purchases.addPurchaserInfoUpdateListener(_purchaserInfoUpdated);
  }

  Future<void> setupCallback() async {}

  // RevenueCatの認証。UserSetupで利用 参考：https://docs.revenuecat.com/docs/user-ids#logging-back-in
  // 利用場所を検索しやすいように独自にプロパティを用意した。
  // 識別子には、public_uidを将来的にユーザーが変更できるようにする可能性も考慮して、インクリメンタルなIDを利用する。
  static Future<void> identify(String userId) async {
    await Purchases.logIn(userId);
  }

  // プレミアムプランのIDを取得
  Future<String?> fetchProductID() async {
    Offerings offerings = await Purchases.getOfferings();
    final product = offerings.current!.monthly!.product;
    return product.identifier;
  }

  // 購入処理。
  // 購入が完了したらtrueを返す。購入がキャンセルされればfalseを返す。
  Future<bool> subscribe(String productID) async {
    try {
      isExecuting = true;
      //print(".subscribe");
      final info = await Purchases.purchaseProduct(productID);
      final isSubscribed = await syncSubscription(info);
      isExecuting = false;
      return isSubscribed;
    } catch (e) {
      // TODO: エラーハンドリング（後述）
      isExecuting = false;
      return false;
    }
  }

  // RailsのDB側も同期して課金ユーザーとして設定する。
  Future<bool> syncSubscription(PurchaserInfo info) async {
    isExecuting = true;
    bool isSubscribed = false;

    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    // tokenがないならそもそもリクエストを飛ばさない。
    if (token == null) {
      isExecuting = false;
      print(".syncSubscription: token not found");
      return isSubscribed;
    }

    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/api/v1/mobile/users/sync_subscription');
    var res = await http.post(url, body: {'token': token});
    //print(".syncSubscription: response");
    print('.syncSubscription: response ${res.statusCode}');
    if (res.statusCode != 200) {
      isExecuting = false;
      return isSubscribed;
    }

    Map resMap = json.decode(res.body);
    print('premium:' + resMap['user']['premium']);
    print('paidViaNativeApp:' + resMap['user']['paid_via_native_app']);
    isExecuting = false;
    return true;
  }

  // リストア処理
  Future<bool> restore() async {
    //bool isExecuting = true;
    final info = await Purchases.restoreTransactions();
    bool result = await syncSubscription(info);
    return result;
  }
}
