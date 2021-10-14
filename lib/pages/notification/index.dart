import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/entrance.dart';
import 'package:flutter/material.dart';

class NotificationIndexPage extends StatefulWidget {
  const NotificationIndexPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(notificationIndexPage);
  }

  @override
  _NotificationIndexPageState createState() => _NotificationIndexPageState();
}

class _NotificationIndexPageState extends State<NotificationIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通知'),
        automaticallyImplyLeading: false,
      ),
      body: const Entrance(),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 2),
    );
  }
}
