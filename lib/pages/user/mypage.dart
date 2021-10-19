import 'dart:convert';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/entrance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserMyPage extends StatefulWidget {
  const UserMyPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(userMyPage);
  }

  @override
  _UserMyPageState createState() => _UserMyPageState();
}

class _UserMyPageState extends State<UserMyPage> {
  User? _user;

  void initState() {
    super.initState();
    _loadUser();
  }

  Future _logout() async {
    // トークンを削除
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
    const snackBar = SnackBar(content: Text('ログアウトしました。'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    UserMyPage.push(context);
  }

// async create list
  Future _loadUser() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var url = Uri.parse('http://localhost:3000/ja/api/v1/mobile/users/my_page');
    var res = await http.post(url, body: {'token': '$token'});
    if (res.statusCode == 200) {
      // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
      Map resMap = json.decode(res.body);
      const storage = FlutterSecureStorage();
      await storage.write(
          key: 'remindersCount', value: resMap['reminders_count']);
      await storage.write(
          key: 'notificationsCount', value: resMap['notifications_count']);
      // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
      setState(() {
        _user = User.fromJson(resMap['user']);
      });
    }
  }

  Widget _mypage_or_entrance() {
    if (_user == null) {
      return const Entrance();
    } else {
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
              fontSize: 28.0,
              color: Colors.black54,
              fontWeight: FontWeight.w800),
        ),
      );

      final profile = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          _user?.profile ?? '',
          style: const TextStyle(fontSize: 16.0, color: Colors.black54),
        ),
      );

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
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      }

      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: <Widget>[
            icon,
            userName,
            profile,
            const SizedBox(
              height: 80,
            ),
            _logoutButton()
          ],
        ),
      );
    }
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
