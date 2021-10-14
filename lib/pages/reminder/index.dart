import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/shared/bottom_navbar.dart';
import 'package:booqs_mobile/widgets/shared/entrance.dart';
import 'package:flutter/material.dart';

class ReminderIndexPage extends StatefulWidget {
  const ReminderIndexPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(reminderIndexPage);
  }

  @override
  _ReminderIndexPageState createState() => _ReminderIndexPageState();
}

class _ReminderIndexPageState extends State<ReminderIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('復習'),
        automaticallyImplyLeading: false,
      ),
      body: const Entrance(),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 1),
    );
  }
}
