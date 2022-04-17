import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/home/home_search_page.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref.refresh(asyncCurrentUserProvider);
    });
    super.initState();
  }

  /* @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadCurrentUser();
  }

  // 現在のユーザー情報を更新する
  Future _loadCurrentUser() async {
    Map? resMap = await RemoteUsers.status(context);

    if (resMap == null) {
      await UserSetup.logOut(null);
      ref.read(currentUserProvider.notifier).state = null;
      ref.read(answerSettingProvider.notifier).state = null;
      ref.read(todaysAnswersCountProvider.notifier).state = 0;
      return;
    }

    User user = User.fromJson(resMap['user']);
    await UserSetup.signIn(user);
    ref.read(currentUserProvider.notifier).state = user;
    ref.read(answerSettingProvider.notifier).state = user.answerSetting;
    ref.read(todaysAnswersCountProvider.notifier).state =
        user.todaysAnswerHistoriesCount;
  } */

  /* final List<TabInfo> _tabs = [
    TabInfo("辞書", const HomeSearchPage()),
    TabInfo("単語帳", const HomeChaptersPage()),
  ]; */

  @override
  Widget build(BuildContext context) {
    final future = ref.watch(asyncCurrentUserProvider);
    /* List<Widget> _tabBars() {
      SizeConfig().init(context);
      double grid = SizeConfig.blockSizeHorizontal ?? 0;
      double width = grid * 40;
      return [
        SizedBox(width: width, child: const Tab(text: '検索')),
        SizedBox(width: width, child: const Tab(text: '単語帳')),
      ];
    } */

    return Scaffold(
      appBar: AppBar(
        title: const Text('辞書'),
      ),
      body: const HomeSearchPage(),
      bottomNavigationBar: const BottomNavbar(),
      drawer: const DrawerMenu(),
    );
  }
}
