import 'dart:io' show Platform;
import 'package:booqs_mobile/consts/purchase.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/utils/crashlytics_service.dart';
import 'package:booqs_mobile/utils/env_handler.dart';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

// RevenueCatのセットアップ
// ref： https://docs.revenuecat.com/docs/getting-started-1#section-configure-purchases
// ４系からはメソッドのリネームが発生しているので注意： ref: https://pub.dev/packages/purchases_flutter/changelog
class PurchaseService {
  // 処理実行中にコールバック（_purchaserInfoUpdated）を実行しないための処理
  bool isExecuting = false;

  // RevenueCatの初期化するメソッド（呼んだ回数分コールバックが呼ばれるようになるのでMainで１度だけ実行する）。 ref：https://docs.revenuecat.com/docs/getting-started#7-configure-the-purchases-sdk
  Future<void> initPlatformState() async {
    if (EnvHandler.isDesktop()) return;
    // デバック用のログを表示する
    //await Purchases.setDebugLogsEnabled(true);

    PurchasesConfiguration configuration;
    if (Platform.isAndroid) {
      final String? publicAndroidSdkKey =
          dotenv.env['REVENUECAT_ANDROID_PUBLIC_KEY'];
      configuration = PurchasesConfiguration(publicAndroidSdkKey!);
      await Purchases.configure(configuration);
      //await Purchases.setup('$publicAndroidSdkKey');
    } else if (Platform.isIOS) {
      final String? publicIosSdkKey = dotenv.env['REVENUECAT_IOS_PUBLIC_KEY'];
      configuration = PurchasesConfiguration(publicIosSdkKey!);
      await Purchases.configure(configuration);
      //await Purchases.setup('$publicIosSdkKey');
    }

    // アプリ起動時などのコールバック時に実行され、契約状況をDBと同期する。
    Future<void> purchaserInfoUpdated(CustomerInfo info) async {
      if (EnvHandler.isDesktop()) return;
      // print('purchaserInfoUpdated: $isExecuting');
      // print('_purchaserInfoUpdated: isEmpty? ${info.entitlements.all.isEmpty}');
      if (isExecuting) return;
      await syncSubscription(info);
    }

    // 契約情報更新時のイベントを捕捉するリスナー ref: https://docs.revenuecat.com/docs/purchaserinfo#listening-for-purchaser-info-updates
    Purchases.addCustomerInfoUpdateListener(purchaserInfoUpdated);
  }

  // RevenueCatのユーザー認証。UserSetupで利用 　ref：https://docs.revenuecat.com/docs/user-ids#logging-back-in
  // （利用場所を検索しやすいように独自にプロパティを用意した。識別子には、public_uidを将来的にユーザーが変更できるようにする可能性も考慮して、インクリメンタルなIDを利用した。）
  static Future<void> identify(String userId) async {
    if (EnvHandler.isDesktop()) return;
    try {
      await Purchases.logIn(userId);
    } catch (e) {
      CrashlyticsService.recordError(e, null);
    }
  }

  static Future<void> logOut(int id) async {
    if (EnvHandler.isDesktop()) return;
    try {
      Purchases.logOut();
    } catch (e) {
      CrashlyticsService.recordError(e, null);
    }
  }

  // 月額プランのpackageを取得する ref: https://www.revenuecat.com/docs/displaying-products#displaying-packages
  Future<Package?> fetchMonthlyPackage() async {
    try {
      final Offerings offerings = await Purchases.getOfferings();
      final String offeringId = PurchaseConsts.offeringId;
      final Offering? offering = offerings.getOffering(offeringId);
      if (offering == null) {
        // print(".fetchMonthlyPackage: offering doesn't exist.");
        return null;
      }
      final Package? package = offering.monthly;
      if (package == null) {
        // print("fetchMonthlyPackage: Package doesn't exist.");
        return null;
      }
      return package;
    } on PlatformException catch (e, str) {
      CrashlyticsService.recordError(e, str);
      return null;
    }
  }

  // 年額プランのpackageを取得する ref: https://www.revenuecat.com/docs/displaying-products#displaying-packages
  Future<Package?> fetchAnnualPackage() async {
    try {
      final Offerings offerings = await Purchases.getOfferings();
      final String offeringId = PurchaseConsts.offeringId;
      // print(offeringId);
      final Offering? offering = offerings.getOffering(offeringId);
      if (offering == null) {
        // print(".fetchAnnualPackage: offering doesn't exist.");
        return null;
      }
      final Package? package = offering.annual;
      if (package == null) {
        // print("fetchAnnualPackage: Package doesn't exist.");
        return null;
      }
      return package;
    } on PlatformException catch (e, str) {
      CrashlyticsService.recordError(e, str);
      return null;
    }
  }

  // packageを購入する
  // 購入が完了したらtrueを返す。購入がキャンセルされるか、DBの同期が失敗したらfalseを返す。
  Future<bool> purchasePachage(
      Package package, String entitlementIdentifier) async {
    const entitlementId = 'Pro'; // ここを固定文字列 or enum に
    try {
      isExecuting = true;
      // print('purchasePachage: package: $package');
      // print('purchasePachage: entitlementIdentifier: $entitlementIdentifier');
      CustomerInfo purchaserInfo = await Purchases.purchasePackage(package);
      // print('purchasePachage: purchaserInfo: ${purchaserInfo.toJson()}');
      // print('purchasePachage: purchaserInfo.entitlements.all: ${purchaserInfo.entitlements.all}');
      // print('purchasePachage: purchaserInfo.entitlements.all[entitlementIdentifier]: ${purchaserInfo.entitlements.all[entitlementIdentifier]}');
      final entitlement = purchaserInfo.entitlements.active[entitlementId];
      // print('purchasePachage: entitlement: $entitlement');
      if (entitlement != null) {
        final isSubscribed = await getOrCreateSubscriber();
        return isSubscribed;
      } else {
        return false;
      }
    } on PlatformException catch (e, str) {
      CrashlyticsService.recordError(e, str);
      /* var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        print('purchasePachage: error: $e');
      } */
      return false;
    } catch (e, str) {
      CrashlyticsService.recordError(e, str);
      return false;
    } finally {
      // errorであれreturnで外部コードに抜ける前であれ、常に実行する。ref: https://ja.javascript.info/try-catch#ref-1685
      isExecuting = false;
    }
  }

// 月額プランを購入する
  Future<bool> purchaseMonthlyPlan() async {
    final Package? package = await fetchMonthlyPackage();
    if (package == null) {
      return false;
    }
    final completed =
        await purchasePachage(package, PurchaseConsts.monthlyPlanEntitlementId);
    return completed;
  }

// 年額プランを購入する
  Future<bool> purchaseAnnualPlan() async {
    final Package? package = await fetchAnnualPackage();
    if (package == null) {
      return false;
    }
    final completed =
        await purchasePachage(package, PurchaseConsts.annualPlanEntitlementId);
    return completed;
  }

  // 廃止予定
  // 理由はproduct経由ではなく、package経由で購入するため。
  // プレミアムプランのIDを取得。ref: https://www.revenuecat.com/docs/displaying-products#fetching-offerings
  Future<String> fetchProductID() async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null &&
          offerings.current!.availablePackages.isNotEmpty) {
        // Display packages for sale
        StoreProduct product = offerings.current!.monthly!.storeProduct;
        String productID = product.identifier;
        // print('productId: $productID');
        return productID;
      }
    } on PlatformException catch (e, str) {
      CrashlyticsService.recordError(e, str);
      return '';
    }
    return '';
  }

  // DBの同期処理
  // restoreや_purchaserInfoUpdated（コールバック）で利用
  // PurchaserInfo（購入情報）を引数にして、ユーザーの購入状況（契約中か解約済か）をDB側で同期する。
  Future<bool> syncSubscription(CustomerInfo customerInfo) async {
    isExecuting = true;
    bool isSubscribed = false;

    // DBの購入状況を同期する。
    // if文は１つでもプレミアムプランがアクティブなら、trueを返す処理 ref: https://docs.revenuecat.com/docs/purchaserinfo#checking-if-a-user-is-subscribed
    // 現状はプランによって提供機能を変えていないためこれで十分
    if (customerInfo.entitlements.active.isNotEmpty) {
      // print(".syncSubscription: There is active");
      isSubscribed = await enablePremiumOnDB();
    } else {
      // print(".syncSubscription: There is no active");
      // 有効期限が全て切れていたら、DBのpremiumをfalseにする。
      final bool allExpired = isAllExpired(customerInfo);
      if (allExpired) {
        // print(".syncSubscription: All expired");
        disablePremiumOnDB();
      }
      isSubscribed = false;
    }
    isExecuting = false;
    return isSubscribed;
  }

  // DB側の購入処理（DBとの同期）
  // クライアント側で購入を行なっているので、これはDB側の購入の同期処理。
  // サーバー側でユーザーの契約しているサブスクを取得するか、なければ契約して、契約をDBと同期する。 ref: https://docs.revenuecat.com/reference/subscribers
  Future<bool> getOrCreateSubscriber() async {
    final Map? result = await RemoteUsers.getOrCreateSubscriber();
    if (result == null) {
      // print('.getOrCreateSubscriber: response ${res.statusCode}');
      return false;
    }
    return true;
  }

  // すべての契約の有効期限のチェックして、すべて切れていたらtrue、そうでないならfalse
  bool isAllExpired(CustomerInfo customerInfo) {
    final Map<String, EntitlementInfo> entitlementInfoMap =
        customerInfo.entitlements.all;
    // entitlementがすべて有効期限が切れているかどうかを確認する。
    final bool allExpired = entitlementInfoMap.values.every((value) {
      final String? strExpirationDateTime = value.expirationDate;
      if (strExpirationDateTime == null) return false;
      final expirationDatetime = DateTime.parse(strExpirationDateTime);
      // 期限切れならtrue
      final bool expired =
          DateTime.now().isAfter(expirationDatetime) ? true : false;
      return expired;
    });
    return allExpired;
  }

  // DB上で、ユーザーにpremium権限を付与する
  Future<bool> enablePremiumOnDB() async {
    final Map? resMap = await RemoteUsers.enablePremium();
    if (resMap == null) {
      return false;
    }
    return true;
  }

  // DB上で、ユーザーのpremium権限を剥奪する
  Future<bool> disablePremiumOnDB() async {
    final Map? resMap = await RemoteUsers.disablePremium();
    if (resMap == null) {
      return false;
    }
    return true;
  }

  // DB側の解約処理
  // クライアント側に解約APIは用意されていないので、サーバー側（Ruby）の解約APIを叩き、解約をDBと同期する。
  Future<bool> deleteSubscriber(String reason) async {
    final Map? resMap = await RemoteUsers.deleteSubscriber(reason);
    if (resMap == null) {
      return false;
    }
    return true;
  }

  // リストア処理 ref: https://docs.revenuecat.com/docs/restoring-purchases
  Future<bool> restore() async {
    try {
      isExecuting = true;
      final CustomerInfo restoredInfo = await Purchases.restorePurchases();
      // リストアできる購入情報が存在しなければ、falseを返す。
      // if文はアクティブなサブスクが一つもなければtrueを返す処理 ref:  https://docs.revenuecat.com/docs/purchaserinfo#checking-if-a-user-is-subscribed
      if (restoredInfo.entitlements.active.isEmpty) return false;
      final bool result = await syncSubscription(restoredInfo);
      return result;
    } on PlatformException catch (e, str) {
      CrashlyticsService.recordError(e, str);
      return false;
    } finally {
      isExecuting = false;
    }
  }
}
