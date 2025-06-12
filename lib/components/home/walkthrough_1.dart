import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeWalkthrough1 extends StatefulWidget {
  const HomeWalkthrough1({super.key});

  @override
  State<HomeWalkthrough1> createState() => _HomeWalkthrough1State();
}

class _HomeWalkthrough1State extends State<HomeWalkthrough1> {
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
          'https://www.youtube.com/embed/h6dJQTLmOfY?autoplay=0&fs=1&iv_load_policy=3&showinfo=0&rel=0&cc_load_policy=0&start=0&end=0'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            t.home.welcome,
            style: GoogleFonts.mPlusRounded1c(
              textStyle: Theme.of(context).textTheme.headlineMedium,
              color: Colors.white,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            t.home.welcome_description_1,
            style: GoogleFonts.mPlusRounded1c(
              textStyle: Theme.of(context).textTheme.headlineSmall,
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        // YouTube動画プレーヤー (WebView)
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
                child: WebViewWidget(controller: _webViewController),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
