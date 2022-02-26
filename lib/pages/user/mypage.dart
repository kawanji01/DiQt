import 'dart:convert';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/services/purchase.dart';
import 'package:booqs_mobile/utils/device_indentifier.dart';
import 'package:booqs_mobile/utils/user_setup.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/drawer_menu.dart';
import 'package:booqs_mobile/widgets/shared/entrance.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:booqs_mobile/widgets/user/user_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserMyPage extends StatefulWidget {
  const UserMyPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    //return Navigator.of(context).pushNamed(userMyPage);
    // アニメーションなしで画面遷移させる。 ref： https://stackoverflow.com/questions/49874272/how-to-navigate-to-other-page-without-animation-flutter
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

    if (token == null) {
      return setState(() {
        _initDone = true;
      });
    }

    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/users/status');
    var res = await http.post(url, body: {'token': token});

    if (res.statusCode != 200) {
      await UserSetup.logOut();
      return setState(() {
        _initDone = true;
      });
    }

    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map resMap = json.decode(res.body);
    await UserSetup.signIn(resMap);
    setState(() {
      _user = User.fromJson(resMap['user']);
      _initDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ログアウト
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
      await UserSetup.logOut();
      // ローディングを消す
      EasyLoading.dismiss();
      const snackBar = SnackBar(content: Text('ログアウトしました。'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      UserMyPage.push(context);
    }

    // Webのアカウント設定に飛ぶ
    Future _moveToAccountSetting() async {
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

    Future _pushPopup(value) async {
      switch (value) {
        case 0:
          _moveToAccountSetting();
          break;
        case 1:
          _logout();
          break;
      }
    }

    Widget _settingButton() {
      if (_initDone == false) {
        return Container();
      }

      if (_user == null) return Container();

      // PopupMenuButton 参考： https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
      return PopupMenuButton(
        onSelected: (newValue) {
          _pushPopup(newValue);
        },
        itemBuilder: (BuildContext context) => [
          const PopupMenuItem(
            child: Text(
              'アカウント設定',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            value: 0,
          ),
          const PopupMenuItem(
            child: Text(
              'ログアウト',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            value: 1,
          )
        ],
      );
    }

    // マイページを表示するか、ログインしてなければログインボタンを表示する。
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

    // 最終的なアウトプット
    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
        //automaticallyImplyLeading: false,
        actions: <Widget>[_settingButton()],
      ),
      body: _mypageOrEntrance(),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 3),
      drawer: const DrawerMenu(),
    );
  }
}
