import 'package:booqs_mobile/components/ad/base_ad_banner.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdSmallBanner extends StatelessWidget {
  const AdSmallBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseAdBanner(
      adSize: AdSize.banner, // 320×50の小さいバナーサイズ
    );
  }
}
