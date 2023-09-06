import 'package:booqs_mobile/components/school/activities.dart';
import 'package:booqs_mobile/components/school/chapters.dart';
import 'package:booqs_mobile/components/school/members.dart';
import 'package:booqs_mobile/data/provider/school.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/tab_info.dart';
import 'package:booqs_mobile/components/school/drawer.dart';
import 'package:booqs_mobile/components/school/ranking.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchoolShowPage extends ConsumerStatefulWidget {
  const SchoolShowPage({Key? key}) : super(key: key);

  static Future pushReplacement(BuildContext context) async {
    //return Navigator.of(context).pushNamed(reviewIndexPage);
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        // 画面遷移のログを送信するために、settings.nameを設定する。
        settings: const RouteSettings(name: schoolShowPage),
        pageBuilder: (context, animation1, animation2) =>
            const SchoolShowPage(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  SchoolShowPageState createState() => SchoolShowPageState();
}

class SchoolShowPageState extends ConsumerState<SchoolShowPage> {
  final List<TabInfo> _tabs = [
    TabInfo(t.chapters.chapters, const SchoolChapters()),
    TabInfo(t.activities.activities, const SchoolActivities()),
    TabInfo(t.ranking.ranking, const SchoolRanking()),
    TabInfo(t.schools.members, const SchoolMembers()),
  ];

  @override
  Widget build(BuildContext context) {
    final future = ref.watch(asyncSchoolProvider);

    List<Widget> tabBars() {
      SizeConfig().init(context);
      double grid = SizeConfig.blockSizeHorizontal ?? 0;
      double width = grid * 25;
      return [
        SizedBox(width: width, child: Tab(text: t.chapters.chapters)),
        SizedBox(width: width, child: Tab(text: t.activities.activities)),
        SizedBox(width: width, child: Tab(text: t.ranking.ranking)),
        SizedBox(width: width, child: Tab(text: t.schools.members)),
      ];
    }

    return DefaultTabController(
      initialIndex: 0,
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: future.when(
            data: (school) => Text(school?.name ?? ''),
            error: (err, stack) => Text('Error: $err'),
            loading: () => const Text(''),
          ),
          bottom: TabBar(isScrollable: true, tabs: tabBars()),
          // タイトル部分を消す ref: https://blog.mrym.tv/2019/09/flutter-tabbar-without-appbar-title/
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveValues.horizontalMargin(context),
          ),
          //child: TabBarView(children: _tabs.map((tab) => tab.widget).toList()),
          child: future.when(
            data: (data) =>
                TabBarView(children: _tabs.map((tab) => tab.widget).toList()),
            error: (err, stack) => Text('Error: $err'),
            loading: () => const LoadingSpinner(),
          ),
        ),
        bottomNavigationBar: const BottomNavbar(),
        drawer: const SchoolDrawer(),
      ),
    );
  }
}
