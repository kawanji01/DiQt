import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/home/community_page.dart';
import 'package:booqs_mobile/utils/app_review_service.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:booqs_mobile/widgets/shared/contact_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerMenu extends ConsumerWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? _user = ref.watch(currentUserProvider);

    return Drawer(
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
            title: const Text('コミュニティ', style: TextStyle(fontSize: 16)),
            onTap: () {
              CommunityPage.push(context);
            },
          ),
          ListTile(
            title: const Text('お問い合わせ', style: TextStyle(fontSize: 16)),
            onTap: () {
              if (_user == null) {
                // ログインしていないなら、ブラウザ経由で問い合わせ方法を提示する
                WebPageLauncher.open('https://www.diqt.net/ja/contact');
              } else {
                // ログインしているならお問い合わせフィームをモーダル表示
                Dialogs.reward(const ContactFormScreen());
              }
            },
          ),
          ListTile(
            title: const Text('レビュー', style: TextStyle(fontSize: 16)),
            onTap: () {
              AppReviewService.request();
            },
          ),
          ListTile(
            title: const Text('利用規約', style: TextStyle(fontSize: 16)),
            onTap: () {
              WebPageLauncher.open('https://www.diqt.net/ja/terms_of_service');
            },
          ),
          ListTile(
            title: const Text('プライバシーポリシー', style: TextStyle(fontSize: 16)),
            onTap: () {
              WebPageLauncher.open('https://www.diqt.net/ja/privacy_policy');
            },
          ),
          ListTile(
            title: const Text('特定商取引法に基づく表記', style: TextStyle(fontSize: 16)),
            onTap: () {
              WebPageLauncher.open('https://www.diqt.net/ja/legal');
            },
          ),
          ListTile(
            title: const Text('運営会社', style: TextStyle(fontSize: 16)),
            onTap: () {
              WebPageLauncher.open('https://www.diqt.net/ja/about');
            },
          ),
        ],
      ),
    );
  }
}
