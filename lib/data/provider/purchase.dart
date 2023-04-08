// 非同期でログイン済ユーザーを取得する
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

final asyncCustomerInfoProvider = FutureProvider<CustomerInfo?>((ref) async {
  try {
    // CustomerInfoのCacheをclearする。
    await Purchases.invalidateCustomerInfoCache();
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    // 契約状態を更新する
    //inal purchase = PurchaseService();
    //await purchase.syncSubscription(customerInfo);
    return customerInfo;
  } on PlatformException catch (e) {
    // Error fetching customer info
    print(e);
    return null;
  }
});
