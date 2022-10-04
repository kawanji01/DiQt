import 'package:booqs_mobile/data/provider/chapter.dart';
import 'package:booqs_mobile/models/tab_info.dart';
import 'package:booqs_mobile/widgets/chapter/school/drawer.dart';
import 'package:booqs_mobile/widgets/chapter/school/ranking.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/widgets/chapter/school/activities.dart';
import 'package:booqs_mobile/widgets/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/chapter/school/drills.dart';
import 'package:booqs_mobile/widgets/shared/drawer_menu.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChapterSchoolPage extends ConsumerStatefulWidget {
  const ChapterSchoolPage({Key? key}) : super(key: key);

  static Future pushReplacement(BuildContext context) async {
    //return Navigator.of(context).pushNamed(reviewIndexPage);
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        // 画面遷移のログを送信するために、settings.nameを設定する。
        settings: const RouteSettings(name: chapterSchoolPage),
        pageBuilder: (context, animation1, animation2) =>
            const ChapterSchoolPage(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  _ChapterSchoolPageState createState() => _ChapterSchoolPageState();
}

class _ChapterSchoolPageState extends ConsumerState<ChapterSchoolPage> {
  final List<TabInfo> _tabs = [
    TabInfo("問題集", const ChapterSchoolDrills()),
    TabInfo("活動", const ChapterSchoolActivities()),
    TabInfo("ランキング", const ChapterSchoolRanking()),
  ];

  @override
  Widget build(BuildContext context) {
    final future = ref.watch(asyncSchoolProvider);

    List<Widget> _tabBars() {
      SizeConfig().init(context);
      double grid = SizeConfig.blockSizeHorizontal ?? 0;
      double width = grid * 30;
      return [
        SizedBox(width: width, child: const Tab(text: '問題集')),
        SizedBox(width: width, child: const Tab(text: '活動')),
        SizedBox(width: width, child: const Tab(text: 'ランキング')),
      ];
    }

    return DefaultTabController(
      initialIndex: 0,
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: future.when(
            data: (data) => Text(data?.title ?? ''),
            error: (err, stack) => Text('Error: $err'),
            loading: () => const Text(''),
          ),
          bottom: TabBar(isScrollable: true, tabs: _tabBars()),
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
        drawer: const ChapterSchoolDrawer(),
      ),
    );
  }
}
