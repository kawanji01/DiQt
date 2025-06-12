import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/components/shared/hero.dart';
import 'package:booqs_mobile/consts/images.dart';
import 'package:booqs_mobile/data/provider/locale.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OtherAppsScreen extends ConsumerStatefulWidget {
  const OtherAppsScreen({super.key});

  @override
  ConsumerState<OtherAppsScreen> createState() => _OtherAppsScreenState();
}

class _OtherAppsScreenState extends ConsumerState<OtherAppsScreen> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // ローディングプログレスを更新
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(
          'https://www.youtube.com/embed/_H-atLPdQSM?autoplay=0&fs=1&iv_load_policy=3&showinfo=0&rel=0&cc_load_policy=0&start=0&end=0'));
  }

  @override
  Widget build(BuildContext context) {
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
              // YouTube動画プレーヤー (WebView)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 220, // 16:9のアスペクト比を維持
                    child: WebViewWidget(controller: _webViewController),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SharedHero(
                  tag: 'chromeSearch',
                  url: '$mainImagesUrl/chrome_search_$locale.png'),
              const SizedBox(
                height: 24,
              ),
              SharedHero(
                  tag: 'chromeSettingReview',
                  url: '$mainImagesUrl/chrome_setting_review_$locale.png'),
              const SizedBox(
                height: 24,
              ),
              SharedHero(
                  tag: 'chromeReview',
                  url: '$mainImagesUrl/chrome_review_$locale.png'),
              const SizedBox(
                height: 24,
              ),
              SharedHero(
                  tag: 'chromeTranslation',
                  url: '$mainImagesUrl/chrome_translation_$locale.png'),
              const SizedBox(
                height: 24,
              ),
              SharedHero(
                  tag: 'AISearch',
                  url:
                      'https://lh3.googleusercontent.com/j6EWuNLAQAganHTY82WjPka-CXEIofwbLnEtKftkUkqcOB1JmdpU9yZA60VE_xbH7LYq0vkrWMJWj65-JcU0nJlI=s1280-w1280-h800'),
              const SizedBox(
                height: 24,
              ),
              Text(
                t.layouts.chrome_extension_description_2,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () => WebPageLauncher.openByExternalBrowser(
                    t.layouts.chrome_web_store_url),
                child: MediumGreenButton(
                    label: t.layouts.open_diqt_extension,
                    fontSize: 16,
                    icon: Icons.download),
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
