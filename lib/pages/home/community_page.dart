import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/widgets/bottom_navbar/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(communityPage);
  }

  @override
  Widget build(BuildContext context) {
    final heading = RichText(
        text: const TextSpan(children: [
      WidgetSpan(
        child: FaIcon(
          FontAwesomeIcons.discord,
          size: 32,
          color: Colors.green,
        ),
      ),
      TextSpan(
          text: ' DiQt Community',
          style: TextStyle(
              color: Colors.green, fontSize: 32, fontWeight: FontWeight.bold))
    ]));

    const style = TextStyle(
        color: Colors.black87,
        fontSize: 16,
        height: 1.7,
        fontWeight: FontWeight.normal);

    final introduction = RichText(
        text: const TextSpan(children: [
      TextSpan(
          text: '''DiQt Community（ディクト・コミュニティ）は、DiQtユーザーのためのオンラインコミュニティです。\n''',
          style: style),
      TextSpan(
          text: '''このコミュニティでは、DiQtについて、直接開発者によるサポートを受けられます。\n''', style: style)
    ]));

    //
    Future<void> _moveToDiscord() async {
      const String url = "https://discord.gg/N7zUGMJ";
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
        );
      }
    }

    //
    final discordButton = ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: const Color(0xff7289da),
        minimumSize: const Size(double.infinity, 56),
      ),
      onPressed: () => {_moveToDiscord()},
      icon: const FaIcon(
        FontAwesomeIcons.discord,
        color: Colors.white,
        size: 22,
      ),
      label: const Text(
        'コミュニティに参加する',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('コミュニティ'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: 32,
            horizontal: ResponsiveValues.horizontalMargin(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading,
            const SizedBox(height: 16),
            introduction,
            const SizedBox(height: 32),
            discordButton,
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
