import 'package:booqs_mobile/components/inquiry/screen.dart';
import 'package:booqs_mobile/consts/sources.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/home/community_page.dart';
import 'package:booqs_mobile/utils/app_review_service.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerMenu extends ConsumerWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);

    return Drawer(
      backgroundColor: Colors.white,
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text(
              'DiQt',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text(t.home.help_page, style: const TextStyle(fontSize: 16)),
            onTap: () {
              WebPageLauncher.openByWebView(helpPageUrl);
            },
          ),
          ListTile(
            title: Text(t.home.community, style: const TextStyle(fontSize: 16)),
            onTap: () {
              HomeCommunityPage.push(context);
            },
          ),
          ListTile(
            title: Text(t.home.contact, style: const TextStyle(fontSize: 16)),
            onTap: () {
              if (user == null) {
                // ログインしていないなら、ブラウザ経由で問い合わせ方法を提示する
                WebPageLauncher.openByWebView(contactUrl);
              } else {
                // ログインしているならお問い合わせフィームをモーダル表示
                Dialogs.slideFromBottomFade(const InquiryScreen());
              }
            },
          ),
          ListTile(
            title: Text(t.home.cheer_app, style: const TextStyle(fontSize: 16)),
            onTap: () async {
              await AppReviewService().request();
            },
          ),
          ListTile(
            title: Text(t.home.temrs_of_service,
                style: const TextStyle(fontSize: 16)),
            onTap: () {
              WebPageLauncher.openByWebView(termsOfServiceUrl);
            },
          ),
          ListTile(
            title: Text(t.home.privacy_policy,
                style: const TextStyle(fontSize: 16)),
            onTap: () {
              WebPageLauncher.openByWebView(privacyPolicyUrl);
            },
          ),
          ListTile(
            title: Text(t.home.legal, style: const TextStyle(fontSize: 16)),
            onTap: () {
              WebPageLauncher.openByWebView(legalUrl);
            },
          ),
          ListTile(
            title: Text(t.home.company, style: const TextStyle(fontSize: 16)),
            onTap: () {
              WebPageLauncher.openByWebView(companyUrl);
            },
          ),
        ],
      ),
    );
  }
}
