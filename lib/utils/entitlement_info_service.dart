import 'package:purchases_flutter/object_wrappers.dart';

class EntitlementInfoService {
  // 契約端末のOSを返す
  static String device(EntitlementInfo entitlementInfo) {
    if ('${entitlementInfo.store}' == 'Store.appStore') {
      return 'ios';
    } else {
      return 'Android';
    }
  }

  // トライアル中かどうか
  static bool inTrial(EntitlementInfo entitlementInfo) {
    if ('${entitlementInfo.periodType}' == 'Trial') {
      return true;
    } else {
      return false;
    }
  }
}
