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
}
