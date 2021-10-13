import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/widgets/dictionary/bottom_navbar.dart';
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
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 1),
    );
  }
}
