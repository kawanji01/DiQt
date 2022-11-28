import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:url_launcher/url_launcher.dart';

class WebPageLauncher {
  // WebViewで開く
  static Future<void> openByWebView(
    String urlStr,
  ) async {
    final String encodedUrlStr = Uri.encodeFull(urlStr);
    final Uri url = Uri.parse(encodedUrlStr);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.inAppWebView);
    }
  }

  // 外部ブラウザで開く
  static Future<void> openByExternalBrowser(
    String urlStr,
  ) async {
    final String encodedUrlStr = Uri.encodeFull(urlStr);
    final Uri url = Uri.parse(encodedUrlStr);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  // Googleで単語を調べる。
  static Future<void> searchEntryByGoogle(
    String entry,
  ) async {
    final String meaning = t.words.meaning;
    final String url =
        "https://www.google.com/search?q=$entry+$meaning&oq=$entry+$meaning";
    openByExternalBrowser(url);
  }
}
