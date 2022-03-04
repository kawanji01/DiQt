import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppBanner extends StatefulWidget {
  const AppBanner({Key? key, this.adSize, this.adUnitId = ''})
      : super(key: key);

  final AdSize? adSize;
  final String adUnitId;

  @override
  State<AppBanner> createState() => _AppBannerState();
}

class _AppBannerState extends State<AppBanner> {
  BannerAd? bannerAd;

  @override
  void initState() {
    super.initState();
    _setAd();
  }

  Future _setAd() async {
    final bool isPremium = await _isPremium();
    if (isPremium) return;

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

  // ユーザーがプレミアム会員か確認する。
  Future<bool> _isPremium() async {
    const storage = FlutterSecureStorage();
    String? premium = await storage.read(key: 'premium');
    return premium == 'true';
  }

  // 広告IDを取得する
  String getAdUnitId() {
    if (widget.adUnitId != '') {
      return widget.adUnitId;
    }

    if (Platform.isIOS) {
      if (kDebugMode) {
        print('debug');
        // テスト用の広告
        return 'ca-app-pub-3940256099942544/2934735716';
      }
      print('not debug');
      String? iosBannerAdID = dotenv.env['IOS_BANNER_AD_ID'];
      return '$iosBannerAdID';
    }
    print('Android');
    String? androidBannerAdID = dotenv.env['ANDROID_BANNER_AD_ID'];
    return '$androidBannerAdID';
  }

  @override
  Widget build(BuildContext context) {
    // プレミアム会員なら広告を表示しない。（initState時点で広告を読み込まない）
    if (bannerAd == null) {
      return Container(height: 0);
    }

    if (widget.adSize == null) {
      print('widget.adSize == null');
      return Container(
        alignment: Alignment.center,
        child: AdWidget(ad: bannerAd!),
        height: 90,
      );
    }

    return Container(
      alignment: Alignment.center,
      child: AdWidget(ad: bannerAd!),
      width: bannerAd!.size.width.toDouble(),
      height: bannerAd!.size.height.toDouble(),
    );
  }
}
