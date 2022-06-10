import 'package:app_review/app_review.dart';
import 'package:booqs_mobile/pages/home/community_page.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 問い合わせページへの移動
    Future _moveToContactPage() async {
      // 外部リンクダイアログを表示
      await showDialog(
          context: context,
          builder: (context) {
            // ./locale/ を取り除いたpathを指定する
            return const ExternalLinkDialog(redirectPath: 'contact');
          });
    }

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
              _moveToContactPage();
            },
          ),
          ListTile(
            title: const Text('レビュー', style: TextStyle(fontSize: 16)),
            onTap: () {
              AppReview.requestReview.then((onValue) {
                print(onValue);
              });
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
