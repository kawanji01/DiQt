import 'package:booqs_mobile/components/dictionary_map/floating_action_button.dart';
import 'package:booqs_mobile/data/provider/dictionary_map.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/tab_info.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/components/chapter/index.dart';
import 'package:booqs_mobile/components/dictionary_map/search_screen.dart';
import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  static Future push(BuildContext context) async {
    //return Navigator.of(context).pushNamed(indexPage);
    // アニメーションなしで画面遷移させる。 参考： https://stackoverflow.com/questions/49874272/how-to-navigate-to-other-page-without-animation-flutter
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        // 画面遷移のログを送信するために、settings.nameを設定する。
        settings: const RouteSettings(name: indexPage),
        pageBuilder: (context, animation1, animation2) => const HomePage(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  final List<TabInfo> _tabs = [
    TabInfo("辞書", const DictionaryMapSearchScreen()),
    TabInfo("単語帳", const ChapterIndex()),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(asyncCurrentUserProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabBars() {
      SizeConfig().init(context);
      double grid = SizeConfig.blockSizeHorizontal ?? 0;
      double width = grid * 40;
      return [
        SizedBox(width: width, child: const Tab(text: '辞書')),
        SizedBox(width: width, child: const Tab(text: '単語帳')),
      ];
    }

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Builder(
        builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            // この条件式がないとタブ移動時に2回実行される。
            if (!tabController.indexIsChanging) {
              if (tabController.index == 0) {
                ref
                    .read(dictionaryMapFloatingActionButtonProvider.notifier)
                    .state = const DictionaryMapFloatingActionButton();
              } else {
                ref
                    .read(dictionaryMapFloatingActionButtonProvider.notifier)
                    .state = null;
              }
            }
          });
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                // タイトル部分を消す ref: https://blog.mrym.tv/2019/09/flutter-tabbar-without-appbar-title/
                flexibleSpace: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TabBar(isScrollable: true, tabs: tabBars()),
                  ],
                ),
              ),
              body: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: ResponsiveValues.horizontalMargin(context),
                ),
                child: TabBarView(
                    children: _tabs.map((tab) => tab.widget).toList()),
              ),
              bottomNavigationBar: const BottomNavbar(),
              floatingActionButton: ref.watch(
                  dictionaryMapFloatingActionButtonProvider) // tabIndexが0でないときは、FloatingActionButtonを表示しない
              );
        },
      ),
    );
  }
}
