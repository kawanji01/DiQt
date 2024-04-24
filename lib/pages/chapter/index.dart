import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/components/chapter/index.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/layouts/drawer_menu.dart';
import 'package:flutter/material.dart';

class ChapterIndexPage extends StatelessWidget {
  const ChapterIndexPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        // 画面遷移のログを送信するために、settings.nameを設定する。
        settings: const RouteSettings(name: chapterIndexPage),
        pageBuilder: (context, animation1, animation2) =>
            const ChapterIndexPage(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.layouts.word_list),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: ResponsiveValues.horizontalMargin(context)),
          child: const ChapterIndex(),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
      drawer: const DrawerMenu(),
    );
  }
}
