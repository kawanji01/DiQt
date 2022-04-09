import 'dart:convert';
import 'package:booqs_mobile/data/provider/answer_setting_provider.dart';
import 'package:booqs_mobile/data/provider/logged_in_user_provider.dart';
import 'package:booqs_mobile/models/tab_info.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:booqs_mobile/widgets/home/home_chapters_page.dart';
import 'package:booqs_mobile/widgets/home/home_search_page.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends ConsumerStatefulWidget {
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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadBadgeCount();
  }

  // 復習と通知のカウントを更新する
  Future _loadBadgeCount() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    if (token == null) return;

    Uri url = Uri.parse('${DiQtURL.root(context)}/api/v1/mobile/users/status');
    http.Response res = await http.post(url, body: {'token': token});

    if (res.statusCode != 200) return await UserSetup.logOut();

    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map resMap = json.decode(res.body);
    await UserSetup.signIn(resMap);
    User user = User.fromJson(resMap['user']);
    ref.read(loggedInUserProvider.notifier).state = user;
    ref.read(answerSettingProvider.notifier).state = user.answerSetting;
  }

  final List<TabInfo> _tabs = [
    TabInfo("辞書", const HomeSearchPage()),
    TabInfo("単語帳", const HomeChaptersPage()),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> _tabBars() {
      SizeConfig().init(context);
      double grid = SizeConfig.blockSizeHorizontal ?? 0;
      double width = grid * 40;
      return [
        SizedBox(width: width, child: const Tab(text: '検索')),
        SizedBox(width: width, child: const Tab(text: '単語帳')),
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
        drawer: const DrawerMenu(),
      ),
    );
  }
}
