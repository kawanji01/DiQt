import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:url_launcher/url_launcher.dart';

class WebPageLauncher {
  // WebViewを開く
  static Future<void> openByWebView(
    String urlStr,
  ) async {
    final String encodedUrl = Uri.encodeFull(urlStr);
    final Uri url = Uri.parse(encodedUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  // 外部リンクを開く
  static Future<void> openByExternalBrowser(
    String urlStr,
  ) async {
    final String encodedUrl = Uri.encodeFull(urlStr);
    final Uri url = Uri.parse(encodedUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  // Googleで単語を調べる。
  static Future<void> searchEntryByGoogle(
    String entry,
  ) async {
    final String meaning = t.words.meaning;
    final String url = Uri.encodeFull(
        "https://www.google.com/search?q=$entry+$meaning&oq=$entry+$meaning");
    openByExternalBrowser(url);
  }
}
