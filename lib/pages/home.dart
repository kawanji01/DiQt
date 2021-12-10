import 'dart:convert';
import 'package:app_review/app_review.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/dictionary.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/web_page_launcher.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/dictionary/search_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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
  List<Dictionary> _dictionaries = [];

  // floatingButtonを押した時にフォームにフォーカスさせるための処理 / https://flutter.dev/docs/cookbook/forms/focus
  // Define the focus node. To manage the lifecycle, create the FocusNode in
  // the initState method, and clean it up in the dispose method.（dosposeは定義していない）
  late FocusNode myFocusNode;

  // initialize
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    _loadDictionaries();
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

  // async create list
  Future _loadDictionaries() async {
    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/api/v1/mobile/dictionaries');
    var res =
        await http.get(url, headers: {"Content-Type": "application/json"});
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map<String, dynamic> resMap = json.decode(res.body);
    // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
    resMap['data'].forEach((e) => _dictionaries.add(Dictionary.fromJson(e)));
    setState(() {
      _dictionaries;
    });
  }

  // 問い合わせページへの移動
  Future _moveToContactPage() async {
    // 外部リンクダイアログを表示
    await showDialog(
        context: context,
        builder: (context) {
          // ./locale/ を取り除いたpathを指定する
          return const ExternalLinkDialog(redirectPath: 'contact');
        });
  }

  Future _goToDictionaryPage(Dictionary dictionary) async {
    await DictionaryPage.push(context, dictionary);
  }

  Widget _buildListRow(BuildContext context, int index) {
    final dictionary = _dictionaries[index];

    return ListTile(
      title: Text(dictionary.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios_rounded),
            onPressed: () => _goToDictionaryPage(dictionary),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _drawer() {
      return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'BooQs',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: const Text('お問い合わせ', style: TextStyle(fontSize: 16)),
              onTap: () {
                _moveToContactPage();
              },
            ),
            ListTile(
              title: const Text('レビュー', style: TextStyle(fontSize: 16)),
              onTap: () {
                AppReview.requestReview.then((onValue) {
                  print(onValue);
                });
              },
            ),
            ListTile(
              title: const Text('利用規約', style: TextStyle(fontSize: 16)),
              onTap: () {
                WebPageLauncher.open(
                    'https://www.booqs.net/ja/terms_of_service');
              },
            ),
            ListTile(
              title: const Text('プライバシーポリシー', style: TextStyle(fontSize: 16)),
              onTap: () {
                WebPageLauncher.open('https://www.booqs.net/ja/privacy_policy');
              },
            ),
            ListTile(
              title: const Text('特定商取引法に基づく表記', style: TextStyle(fontSize: 16)),
              onTap: () {
                WebPageLauncher.open('https://www.booqs.net/ja/legal');
              },
            ),
            ListTile(
              title: const Text('運営会社', style: TextStyle(fontSize: 16)),
              onTap: () {
                WebPageLauncher.open('https://www.booqs.net/ja/about');
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('辞書'),
        // 主に戻るボタンを消すために使う。ただしDrawerも消えてしまうため、Drawerを設置する場合は、コメントアウトしておく。
        // automaticallyImplyLeading: false,
      ),

      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            SearchForm(focusNode: myFocusNode),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: _buildListRow,
                separatorBuilder: (context, index) => const Divider(),
                itemCount: _dictionaries.length,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 0),
      floatingActionButton: FloatingActionButton(
        onPressed: () => myFocusNode.requestFocus(),
        tooltip: 'Increment',
        child: const Icon(Icons.search),
      ),
      drawer: _drawer(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
