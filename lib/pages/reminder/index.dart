import 'dart:convert';

import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/entrance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ReminderIndexPage extends StatefulWidget {
  const ReminderIndexPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(reminderIndexPage);
  }

  @override
  _ReminderIndexPageState createState() => _ReminderIndexPageState();
}

class _ReminderIndexPageState extends State<ReminderIndexPage> {
  User? _user;
  int _reminders_count = 0;
  void initState() {
    super.initState();
    _loadReminders();
  }

  Future _moveToReminders() async {
    // トークンを削除
    final url = "https://www.booqs.net/ja/reminders";
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    }
  }

  Future _loadReminders() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var url =
        Uri.parse('http://localhost:3000/ja/api/v1/mobile/reminders/list');
    var res = await http.post(url, body: {'token': '$token'});
    if (res.statusCode == 200) {
      // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
      Map resMap = json.decode(res.body);
      // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
      const storage = FlutterSecureStorage();
      await storage.write(
          key: 'remindersCount', value: resMap['reminders_count']);
      await storage.write(
          key: 'notificationsCount', value: resMap['notifications_count']);
      setState(() {
        _user = User.fromJson(resMap['user']);
        _reminders_count = int.parse(resMap['reminders_count']);
      });
    }
  }

  Widget _remindersPageButton() {
    return InkWell(
      onTap: () {
        _moveToReminders();
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
        child: Text(
          '$_reminders_count問を復習する',
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _remindersOrEntrance() {
    if (_user == null) {
      return const Entrance();
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            _remindersPageButton(),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('復習'),
        automaticallyImplyLeading: false,
      ),
      body: _remindersOrEntrance(),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 1),
    );
  }
}
