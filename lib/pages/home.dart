import 'dart:convert';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/tab_info.dart';
import 'package:booqs_mobile/pages/dictionary/dictionary.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/widgets/home/drills_page.dart';
import 'package:booqs_mobile/widgets/home/search_page.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/drawer_menu.dart';
import 'package:booqs_mobile/widgets/word/word_search_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

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
        pageBuilder: (context, animation1, animation2) => const MyHomePage(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _loadBadgeCount();
  }

  // 復習と通知のカウントを更新する
  Future _loadBadgeCount() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    if (token == null) return;

    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/users/my_page');
    var res = await http.post(url, body: {'token': token});

    if (res.statusCode != 200) return;

    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map resMap = json.decode(res.body);
    await storage.write(key: 'publicUid', value: resMap['user']['public_uid']);
    await storage.write(
        key: 'remindersCount', value: resMap['reminders_count']);
    await storage.write(
        key: 'notificationsCount', value: resMap['notifications_count']);
  }

  final List<TabInfo> _tabs = [
    TabInfo("辞書", const SearchPage()),
    TabInfo("単語帳", const DrillsPage()),
  ];

  //double getProportionWidth(double inputWidth) {
  //final screenWidth = SizeConfig.screenWidth;
  //return (inputWidth / 375.0) * screenWidth;
//}

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    List<Widget> _tabBars() {
      double grid = SizeConfig.blockSizeHorizontal ?? 0;
      double width = grid * 40;

      return [
        SizedBox(width: width, child: Tab(text: '検索')),
        SizedBox(width: width, child: Tab(text: '単語帳')),
      ];
    }

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      //length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('辞書'),
          bottom: TabBar(
            isScrollable: true,
            tabs: _tabBars(),
          ),
          //preferredSize: const Size.fromHeight(30.0),
        ),
        body: TabBarView(children: _tabs.map((tab) => tab.widget).toList()),
        bottomNavigationBar: const BottomNavbar(selectedIndex: 0),
        //floatingActionButton: FloatingActionButton(
        //  onPressed: () => {
        //searchFocusNode.requestFocus();
        //  },
        //  tooltip: 'Increment',
        //  child: const Icon(Icons.search),
        //),
        drawer: const DrawerMenu(),
      ),
    );
  }
}
