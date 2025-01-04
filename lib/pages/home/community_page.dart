import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeCommunityPage extends StatelessWidget {
  const HomeCommunityPage({super.key});

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(communityPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: t.home.community,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: 32,
            horizontal: ResponsiveValues.horizontalMargin(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeadingMediumGreen(
              label: 'DiQt Community',
              icon: FontAwesomeIcons.discord,
            ),
            const SizedBox(height: 16),
            Text(
              t.home.community_description,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 40),
            InkWell(
                onTap: () => WebPageLauncher.openByExternalBrowser(
                    "https://discord.gg/N7zUGMJ"),
                child: MediumGreenButton(
                  label: t.home.join_community,
                  icon: null,
                  fontSize: 20,
                )),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
