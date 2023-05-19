import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/chapter/index.dart';
import 'package:booqs_mobile/components/dictionary_map/floating_action_button.dart';
import 'package:booqs_mobile/components/dictionary_map/search_screen.dart';
import 'package:booqs_mobile/data/provider/dictionary_map.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/tab_info.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeDictionaryScreen extends ConsumerWidget {
  const HomeDictionaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final String dictionary = t.layouts.dictionary;
    final String wordList = t.layouts.word_list;
    final List<TabInfo> tabs = [
      TabInfo(dictionary, const DictionaryMapSearchScreen()),
      TabInfo(wordList, const ChapterIndex()),
    ];
    List<Widget> tabBars() {
      SizeConfig().init(context);
      double grid = SizeConfig.blockSizeHorizontal ?? 0;
      double width = grid * 40;
      return [
        SizedBox(width: width, child: Tab(text: dictionary)),
        SizedBox(width: width, child: Tab(text: wordList)),
      ];
    }

    //
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
                    children: tabs.map((tab) => tab.widget).toList()),
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
