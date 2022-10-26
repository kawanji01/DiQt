import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:url_launcher/url_launcher.dart';

class WebPageLauncher {
  static Future<void> open(
    String url,
  ) async {
    final String encodedUrl = Uri.encodeFull(url);
    if (await canLaunch(encodedUrl)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
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
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    }
  }
}
