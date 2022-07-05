import 'package:booqs_mobile/models/tab_info.dart';
import 'package:booqs_mobile/pages/chapter/ranking.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/widgets/chapter/activities.dart';
import 'package:booqs_mobile/widgets/chapter/drills.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:flutter/material.dart';

class ChapterSchoolPage extends StatefulWidget {
  const ChapterSchoolPage({Key? key}) : super(key: key);

  @override
  State<ChapterSchoolPage> createState() => _ChapterSchoolPageState();
}

class _ChapterSchoolPageState extends State<ChapterSchoolPage> {
  final List<TabInfo> _tabs = [
    TabInfo("問題集", const ChapterDrills()),
    TabInfo("活動", const ChapterActivities()),
    TabInfo("ランキング", const ChapterRanking()),
  ];

  @override
  Widget build(BuildContext context) {
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
          automaticallyImplyLeading: false,
          // タイトル部分を消す ref: https://blog.mrym.tv/2019/09/flutter-tabbar-without-appbar-title/
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TabBar(isScrollable: true, tabs: _tabBars()),
            ],
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveValues.horizontalMargin(context),
          ),
          child: TabBarView(children: _tabs.map((tab) => tab.widget).toList()),
        ),
        bottomNavigationBar: const BottomNavbar(),
      ),
    );
  }
}
