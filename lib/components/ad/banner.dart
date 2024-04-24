import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/utils/ad/app_banner.dart';
import 'package:booqs_mobile/utils/env_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdBanner extends ConsumerWidget {
  const AdBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // デスクトップでは実行しない
    if (EnvHandler.isDesktop()) return Container();

    if (ref.watch(premiumEnabledProvider)) {
      return Container();
    } else {
      return const AppBanner();
    }
  }
}
