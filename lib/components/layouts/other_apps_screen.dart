import 'package:booqs_mobile/components/shared/cache_network_image.dart';
import 'package:booqs_mobile/consts/images.dart';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtherAppsScreen extends ConsumerWidget {
  const OtherAppsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 80%の高さで表示する。
    SizeConfig().init(context);
    final double grid = SizeConfig.blockSizeVertical ?? 0;
    final double height = grid * 80;
    final String locale = ref.watch(localeProvider);

    return SizedBox(
      height: height,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                t.layouts.other_apps,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                t.layouts.other_apps_description,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                t.layouts.chrome_extension,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                t.layouts.chrome_extension_description,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 24,
              ),
              SharedCacheNetworkImage(
                  url: '$mainImagesUrl/chrome_search_$locale.png'),
              const SizedBox(
                height: 16,
              ),
              SharedCacheNetworkImage(
                  url: '$mainImagesUrl/chrome_setting_review_$locale.png'),
              const SizedBox(
                height: 16,
              ),
              SharedCacheNetworkImage(
                  url: '$mainImagesUrl/chrome_review_$locale.png'),
              const SizedBox(
                height: 16,
              ),
              SharedCacheNetworkImage(
                  url: '$mainImagesUrl/chrome_translation_$locale.png'),
              const SizedBox(
                height: 16,
              ),
              const Text(
                '他のアプリ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
