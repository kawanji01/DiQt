import 'dart:convert';
import 'package:app_review/app_review.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/drawer_menu.dart';
import 'package:booqs_mobile/widgets/shared/entrance.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:booqs_mobile/widgets/user/user_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserMyPage extends StatefulWidget {
  const UserMyPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    //return Navigator.of(context).pushNamed(userMyPage);
    // アニメーションなしで画面遷移させる。 参考： https://stackoverflow.com/questions/49874272/how-to-navigate-to-other-page-without-animation-flutter
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        // 画面遷移のログを送信するために、settings.nameを設定する。
        settings: const RouteSettings(name: userMyPage),
        pageBuilder: (context, animation1, animation2) => const UserMyPage(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  _UserMyPageState createState() => _UserMyPageState();
}

class _UserMyPageState extends State<UserMyPage> {
  User? _user;
  bool _initDone = false;

  @override
  void initState() {
    super.initState();
    _loadMyPage();
  }

  // async create list
  Future _loadMyPage() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/users/my_page');
    var res = await http.post(url, body: {'token': '$token'});

    if (res.statusCode != 200) {
      return setState(() {
        _initDone = true;
      });
    }

    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map resMap = json.decode(res.body);
    await storage.write(key: 'publicUid', value: resMap['user']['public_uid']);
    await storage.write(
        key: 'remindersCount', value: resMap['reminders_count']);
    await storage.write(
        key: 'notificationsCount', value: resMap['notifications_count']);
    // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
    setState(() {
      _user = User.fromJson(resMap['user']);
      _initDone = true;
    });
  }

  Future _moveToContactPage() async {
    // 外部リンクダイアログを表示
    await showDialog(
        context: context,
        builder: (context) {
          // ./locale/ を取り除いたpathを指定する
          return const ExternalLinkDialog(redirectPath: 'contact');
        });
  }

  Widget _mypageOrEntrance() {
    if (_initDone == false) return const LoadingSpinner();

    // ログインしていないなら、ログイン・登録画面へ誘導する。
    if (_user == null) return const Entrance();

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 28),
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            UserStatus(user: _user!),
            const SizedBox(
              height: 48,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
        //automaticallyImplyLeading: false,
      ),
      body: _mypageOrEntrance(),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 3),
      drawer: const DrawerMenu(),
    );
  }
}
