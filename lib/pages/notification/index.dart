import 'dart:convert';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/push_notification.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/entrance.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class NotificationIndexPage extends StatefulWidget {
  const NotificationIndexPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(notificationIndexPage);
  }

  @override
  _NotificationIndexPageState createState() => _NotificationIndexPageState();
}

class _NotificationIndexPageState extends State<NotificationIndexPage> {
  User? _user;
  int _notifications_count = 0;
  bool _initDone = false;

  void initState() {
    super.initState();
    _loadCount();
    PushNotification.initialize(context);
  }

  Future _loadCount() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/${Localizations.localeOf(context).languageCode}/api/v1/mobile/notifications/list');
    var res = await http.post(url, body: {'token': '$token'});

    if (res.statusCode != 200) {
      return setState(() {
        _initDone = true;
      });
    }
    // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
    Map resMap = json.decode(res.body);
    await storage.write(
        key: 'notificationsCount',
        value: resMap['notifications_count'].toString());

    // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
    setState(() {
      _user = User.fromJson(resMap['user']);
      _notifications_count = resMap['notifications_count'];
      _initDone = true;
    });
  }

  Future _moveToNotifications() async {
    // 外部リンクダイアログを表示
    await showDialog(
        context: context,
        builder: (context) {
          // ./locale/ を取り除いたpathを指定する
          return const ExternalLinkDialog(redirectPath: 'notifications');
        });
  }

  Widget _notificationsPageButton() {
    return InkWell(
      onTap: () {
        _moveToNotifications();
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
          '$_notifications_count件の通知を見る',
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _notificationsOrEntrance(user) {
    if (_initDone == false) return const LoadingSpinner();

    if (_user == null) return const Entrance();

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(28.0),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 80,
          ),
          _notificationsPageButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通知'),
        automaticallyImplyLeading: false,
      ),
      body: _notificationsOrEntrance(_user),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 2),
    );
  }
}
