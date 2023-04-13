import 'dart:io';

//
class PurchaseConsts {
  static String get offeringId {
    return 'premium plan';
  }

  static String get monthlyPlanEntitlementId {
    return 'diqt_500_1m_2w0';
  }

  static String get annualPlanEntitlementId {
    if (Platform.isAndroid) {
      return 'diqt_5000_1y_2w0:annual-autorenewing';
    } else {
      return 'diqt_5000_1y_2w0';
    }
  }
}
