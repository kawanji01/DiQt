import 'dart:convert';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/push_notification.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/large_button.dart';
import 'package:booqs_mobile/widgets/shared/entrance.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ReminderIndexPage extends StatefulWidget {
  const ReminderIndexPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    //return Navigator.of(context).pushNamed(reminderIndexPage);
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            const ReminderIndexPage(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  _ReminderIndexPageState createState() => _ReminderIndexPageState();
}

class _ReminderIndexPageState extends State<ReminderIndexPage> {
  User? _user;
  int _remindersCount = 0;
  bool _initDone = false;

  @override
  void initState() {
    super.initState();
    _loadReminders();
    PushNotification.initialize(context);
  }

  Future _moveToReminders() async {
    // 外部リンクダイアログを表示
    await showDialog(
        context: context,
        builder: (context) {
          // ./locale/ を取り除いたpathを指定する
          return const ExternalLinkDialog(redirectPath: 'reminders');
        });
  }

  Future _loadReminders() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/reminders/list');
    var res = await http.post(url, body: {'token': '$token'});

    if (res.statusCode != 200) {
      return setState(() {
        _initDone = true;
      });
    }

    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map resMap = json.decode(res.body);
    // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
    await storage.write(
        key: 'remindersCount', value: resMap['reminders_count']);
    await storage.write(
        key: 'notificationsCount', value: resMap['notifications_count']);
    setState(() {
      _user = User.fromJson(resMap['user']);
      _remindersCount = int.parse(resMap['reminders_count']);
      _initDone = true;
    });
  }

  Widget _remindersPageButton() {
    final String btnText = '$_remindersCount問を復習する';
    return InkWell(
      onTap: () {
        _moveToReminders();
      },
      child: LargeButton(btnText: btnText),
    );
  }

  Widget _remindersOrEntrance() {
    if (_initDone == false) return const LoadingSpinner();
    if (_user == null) return const Entrance();

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(28.0),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          const Text('復習を設定した辞書の項目を、問題形式で復習できます。',
              style: TextStyle(fontSize: 16)),
          const SizedBox(
            height: 40,
          ),
          _remindersPageButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('復習'),
        automaticallyImplyLeading: false,
      ),
      body: _remindersOrEntrance(),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 1),
    );
  }
}
