import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/dictionary_map/search_screen.dart';
import 'package:booqs_mobile/components/layouts/drawer_menu.dart';
import 'package:booqs_mobile/components/user/lang_init_screen.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/dictionary_map.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeDictionaryScreen extends ConsumerStatefulWidget {
  const HomeDictionaryScreen({super.key});

  @override
  ConsumerState<HomeDictionaryScreen> createState() =>
      _HomeDictionaryScreenState();
}

class _HomeDictionaryScreenState extends ConsumerState<HomeDictionaryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final User? user = ref.watch(currentUserProvider);
      if (user == null) return;

      if (user.langInitialized == false) {
        // すでに言語設定画面が表示されている場合は表示しない
        final isUserLangInitScreenActive =
            ModalRoute.of(context)?.settings.name == 'UserLangInitScreen';
        if (isUserLangInitScreenActive) return;
        // 言語設定画面を表示
        const screen = UserLangInitScreen();
        Dialogs.slideFromBottomFade(screen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    final String dictionary = t.layouts.dictionary;

    // final String wordList = t.layouts.word_list;
    // final String locale = ref.watch(localeProvider);

    // final List<TabInfo> tabs = [
    //   TabInfo(dictionary, const DictionaryMapSearchScreen()),
    //   TabInfo(wordList, const ChapterIndex()),
    // ];
    // List<Widget> tabBars() {
    //   SizeConfig().init(context);
    //   double grid = SizeConfig.blockSizeHorizontal ?? 0;
    //   double width = grid * 40;
    //   return [
    //     SizedBox(width: width, child: Tab(text: dictionary)),
    //     SizedBox(width: width, child: Tab(text: wordList)),
    //   ];
    // }

    // if (locale == 'ja') {
    //   return DefaultTabController(
    //     initialIndex: 0,
    //     length: 2,
    //     child: Builder(
    //       builder: (BuildContext context) {
    //         final TabController tabController =
    //             DefaultTabController.of(context);
    //         tabController.addListener(() {
    //           // この条件式がないとタブ移動時に2回実行される。
    //           if (!tabController.indexIsChanging) {
    //             if (tabController.index == 0) {
    //               ref
    //                   .read(dictionaryMapFloatingActionButtonProvider.notifier)
    //                   .state = const DictionaryMapFloatingActionButton();
    //             } else {
    //               // tabIndexが0でないときは、FloatingActionButtonを表示しない & キーボードを閉じる
    //               FocusScope.of(context).unfocus();
    //               ref
    //                   .read(dictionaryMapFloatingActionButtonProvider.notifier)
    //                   .state = null;
    //             }
    //           }
    //         });
    //         return Scaffold(
    //             appBar: AppBar(
    //               automaticallyImplyLeading: false,
    //               // タイトル部分を消す ref: https://blog.mrym.tv/2019/09/flutter-tabbar-without-appbar-title/
    //               flexibleSpace: Column(
    //                 mainAxisAlignment: MainAxisAlignment.end,
    //                 children: <Widget>[
    //                   TabBar(isScrollable: true, tabs: tabBars()),
    //                 ],
    //               ),
    //             ),
    //             body: Container(
    //               margin: EdgeInsets.symmetric(
    //                 horizontal: ResponsiveValues.horizontalMargin(context),
    //               ),
    //               child: TabBarView(
    //                   children: tabs.map((tab) => tab.widget).toList()),
    //             ),
    //             bottomNavigationBar: const BottomNavbar(),
    //             floatingActionButton: ref.watch(
    //                 dictionaryMapFloatingActionButtonProvider) // tabIndexが0でないときは、FloatingActionButtonを表示しない
    //             );
    //       },
    //     ),
    //   );
    // }
    return Scaffold(
        appBar: AppBar(
          title: Text(dictionary),
          // automaticallyImplyLeading: false,
          // drawarを表示するためにtrueにする
          automaticallyImplyLeading: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveValues.horizontalMargin(context),
          ),
          child: const DictionaryMapSearchScreen(),
        ),
        bottomNavigationBar: const BottomNavbar(),
        drawer: const DrawerMenu(),
        floatingActionButton: ref.watch(
            dictionaryMapFloatingActionButtonProvider) // tabIndexが0でないときは、FloatingActionButtonを表示しない
        );
  }
}
