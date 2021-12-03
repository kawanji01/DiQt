import 'dart:convert';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/device_indentifier.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/entrance.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

  Future _moveToUserSetting() async {
    const storage = FlutterSecureStorage();
    String? uid = await storage.read(key: 'publicUid');
    // 外部リンクダイアログを表示
    await showDialog(
        context: context,
        builder: (context) {
          // ./locale/ を取り除いたpathを指定する
          return ExternalLinkDialog(redirectPath: 'users/$uid/edit');
        });
  }

  Future _logout() async {
    // 画面全体にローディングを表示
    EasyLoading.show(status: 'loading...');
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    String deviceIdentifier = await DeviceIndentifier.get(context);
    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/sessions/logout');
    await http.post(url,
        body: {'token': '$token', 'device_identifier': deviceIdentifier});
    // トークンをローカルストレージから削除
    await storage.deleteAll();
    // ローディングを消す
    EasyLoading.dismiss();
    const snackBar = SnackBar(content: Text('ログアウトしました。'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    UserMyPage.push(context);
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

  Widget _mypage_or_entrance() {
    if (_initDone == false) return const LoadingSpinner();

    if (_user == null) return const Entrance();

    // 参考：https://github.com/putraxor/flutter-login-ui/blob/master/lib/home_page.dart
    final icon = Hero(
      tag: 'icon',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 72.0,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage('${_user!.icon}'),
        ),
      ),
    );

    final userName = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '${_user!.name}',
        style: const TextStyle(
            fontSize: 28.0, color: Colors.black54, fontWeight: FontWeight.w800),
      ),
    );

    final profile = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        _user?.profile ?? '',
        style: const TextStyle(fontSize: 16.0, color: Colors.black54),
      ),
    );

    Widget _userSettinButton() {
      return InkWell(
        onTap: () {
          _moveToUserSetting();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: const Color(0xff84bf53).withAlpha(100),
                    offset: const Offset(2, 4),
                    blurRadius: 8,
                    spreadRadius: 2)
              ],
              color: Colors.green),
          child: const Text(
            'ユーザー設定',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    Widget _logoutButton() {
      return InkWell(
        onTap: () {
          _logout();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: const Color(0xff84bf53).withAlpha(100),
                    offset: const Offset(2, 4),
                    blurRadius: 8,
                    spreadRadius: 2)
              ],
              color: Colors.green),
          child: const Text(
            'ログアウト',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            icon,
            userName,
            profile,
            const SizedBox(
              height: 80,
            ),
            _userSettinButton(),
            const SizedBox(
              height: 24,
            ),
            _logoutButton(),
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
        automaticallyImplyLeading: false,
      ),
      body: _mypage_or_entrance(),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 3),
    );
  }
}
