import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/utils/env_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BaseAdBanner extends ConsumerWidget {
  const BaseAdBanner({
    super.key,
    this.adSize,
    this.adUnitId = '',
  });

  final AdSize? adSize;
  final String adUnitId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // デスクトップでは実行しない
    if (EnvHandler.isDesktop()) return Container();

    if (ref.watch(premiumEnabledProvider)) {
      return Container();
    } else {
      return AppBanner(
        adSize: adSize,
        adUnitId: adUnitId,
      );
    }
  }
}