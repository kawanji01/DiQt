import 'package:booqs_mobile/consts/sources.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/safe_google_fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeWalkthrough6 extends StatefulWidget {
  const HomeWalkthrough6({super.key});

  @override
  State<HomeWalkthrough6> createState() => _HomeWalkthrough6State();
}

class _HomeWalkthrough6State extends State<HomeWalkthrough6>
    with AutomaticKeepAliveClientMixin {
  WebViewController? _webViewController;
  bool _isWebViewSupported = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  @override
  void dispose() {
    // WebViewのリソースを解放
    _webViewController = null;
    super.dispose();
  }

  void _initializeWebView() {
    // テスト環境かWebViewがサポートされていない環境では初期化しない
    if (!kIsWeb) {
      try {
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
          ..loadRequest(Uri.parse(diqtBrowserExtensionIntroductionYoutubeUrl));
      } catch (e) {
        // WebViewがサポートされていない場合
        _isWebViewSupported = false;
      }
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixinに必要
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'ブラウザ拡張でもっと便利に！',
                style: SafeGoogleFonts.mPlusRounded1c(
                  context: context,
                  textStyle: Theme.of(context).textTheme.headlineMedium,
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // YouTube動画プレーヤー (WebView)
            if (_webViewController != null && _isWebViewSupported)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white30),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 16 / 9, // 16:9のアスペクト比を維持
                      child: WebViewWidget(
                        key: const Key('walkthrough_6_webview'),
                        controller: _webViewController!,
                      ),
                    ),
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    border: Border.all(color: Colors.white30),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_circle_outline,
                            size: 48,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '紹介動画',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                t.home.welcome_description_6,
                style: SafeGoogleFonts.mPlusRounded1c(
                  context: context,
                  textStyle: Theme.of(context).textTheme.headlineSmall,
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
