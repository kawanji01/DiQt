import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// 小さいバナー広告（320x50）
class AppBannerSmall extends StatelessWidget {
  const AppBannerSmall({super.key, this.adUnitId = ''});
  
  final String adUnitId;

  @override
  Widget build(BuildContext context) {
    return AppBanner(
      adSize: AdSize.banner, // 320x50の標準バナーサイズ
      adUnitId: adUnitId,
    );
  }
}