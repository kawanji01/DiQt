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

class AppBannerState extends ConsumerState<AppBanner> with SingleTickerProviderStateMixin {
  BannerAd? bannerAd;
  bool isLoading = true;
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    bannerAd?.dispose();
    super.dispose();
  }

  @override
  // build を実行する前に実行されるメソッド ref: https://zenn.dev/sugitlab/articles/c38ef8d3035289
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 広告をセット
    BannerAd(
      adUnitId: getAdUnitId(),
      size: widget.adSize ?? AdSize.largeBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            bannerAd = ad as BannerAd;
            isLoading = false;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          setState(() {
            isLoading = false;
          });
          ad.dispose();
        },
      ),
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

  Widget _buildSkeleton(double width, double height) {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.grey[300]!,
                          Colors.grey[100]!,
                          Colors.grey[300]!,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                        transform: GradientRotation(_shimmerAnimation.value),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Transform.translate(
                    offset: Offset(_shimmerAnimation.value * width, 0),
                    child: Container(
                      width: width * 0.3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.white.withValues(alpha: 0.0),
                            Colors.white.withValues(alpha: 0.3),
                            Colors.white.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final adSize = widget.adSize ?? AdSize.largeBanner;
    final height = adSize == AdSize.largeBanner ? 90.0 : adSize.height.toDouble();
    final width = MediaQuery.of(context).size.width - 32;

    if (isLoading) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _buildSkeleton(width, height),
      );
    }

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
