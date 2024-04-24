import 'package:booqs_mobile/utils/env_handler.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MobileAdsService {
  static initilize() {
    // デスクトップでは実行しない
    if (EnvHandler.isDesktop()) return;
    MobileAds.instance.initialize();
  }
}
