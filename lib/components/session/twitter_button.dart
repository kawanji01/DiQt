import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SessionTwitterButton extends ConsumerStatefulWidget {
  const SessionTwitterButton({Key? key}) : super(key: key);

  @override
  SessionTwitterButtonState createState() => SessionTwitterButtonState();
}

class SessionTwitterButtonState extends ConsumerState<SessionTwitterButton> {
  String? locale;

  @override
  void initState() {
    super.initState();
    setLocale();
  }

  Future<void> setLocale() async {
    locale = await LocalUserInfo.locale();
  }

  @override
  Widget build(BuildContext context) {
    if (locale == 'ja') {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 24),
        child: TextButton.icon(
          onPressed: () {
            WebPageLauncher.openByWebView(
                'https://booqs.notion.site/Twitter-050d492ab94843a2863ac7a4fb85faae');
          },
          icon: const FaIcon(
            FontAwesomeIcons.twitter,
            size: 20,
            color: Colors.green,
          ),
          label: const Text('Twitter認証をご利用の方々へ',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.bold)),
        ),
      );
    }
    return Container();
  }
}
