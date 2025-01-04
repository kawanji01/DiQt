import 'dart:io';
import 'package:booqs_mobile/utils/env_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppBanner extends ConsumerStatefulWidget {
  const AppBanner({super.key, this.adSize, this.adUnitId = ''});

  final AdSize? adSize;
  final String adUnitId;

  @override
  AppBannerState createState() => AppBannerState();
}

class AppBannerState extends ConsumerState<AppBanner> {
  BannerAd? bannerAd;

  @override
  // build を実行する前に実行されるメソッド ref: https://zenn.dev/sugitlab/articles/c38ef8d3035289
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 広告をセット
    BannerAd(
      adUnitId: getAdUnitId(),
      size: widget.adSize ?? AdSize.largeBanner,
      request: const AdRequest(),
      listener: BannerAdListener(onAdLoaded: (Ad ad) {
        setState(() {
          bannerAd = ad as BannerAd;
        });
      }),
    ).load();
  }

  // 広告IDを取得する
  String getAdUnitId() {
    if (widget.adUnitId != '') {
      return widget.adUnitId;
    }

    if (Platform.isIOS) {
      if (EnvHandler.isDev()) {
        // テスト用の広告
        return 'ca-app-pub-3940256099942544/2934735716';
      }
      String? iosBannerAdID = dotenv.env['IOS_BANNER_AD_ID'];
      return '$iosBannerAdID';
    }
    // print('Android');
    String? androidBannerAdID = dotenv.env['ANDROID_BANNER_AD_ID'];
    return '$androidBannerAdID';
  }

  @override
  Widget build(BuildContext context) {
    if (bannerAd == null) {
      return Container(height: 0);
    }

    if (widget.adSize == null) {
      return Container(
        alignment: Alignment.center,
        height: 90,
        child: AdWidget(ad: bannerAd!),
      );
    }

    return Container(
      alignment: Alignment.center,
      width: bannerAd!.size.width.toDouble(),
      height: bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: bannerAd!),
    );
  }
}
