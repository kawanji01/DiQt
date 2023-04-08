import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/entitlement_info_service.dart';
import 'package:purchases_flutter/object_wrappers.dart';
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

  // 解約のための設定画面を開く
  static Future<void> openCancellationPage(
      EntitlementInfo entitlementInfo) async {
    String url;
    final device = EntitlementInfoService.device(entitlementInfo);
    if (device == 'ios') {
      // App Storeの解約ページ
      url = 'https://apps.apple.com/account/subscriptions';
    } else {
      // Google Playの解約ページ
      url = 'https://play.google.com/store/account/subscriptions';
    }
    await openByWebView(url);
  }
}
