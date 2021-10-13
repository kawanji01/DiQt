import 'package:booqs_mobile/pages/home.dart';
import 'package:booqs_mobile/pages/notification/index.dart';
import 'package:booqs_mobile/pages/reminder/index.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key, required this.selectedIndex}) : super(key: key);

  final int selectedIndex;
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int? _selectedIndex;

  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  // 参考：https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        MyHomePage.push(context);
        break;
      case 1:
        ReminderIndexPage.push(context);
        break;
      case 2:
        NotificationIndexPage.push(context);
        break;
      case 3:
        UserMyPage.push(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '辞書',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.access_alarm),
          label: '復習',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: '通知',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'マイページ',
        ),
      ],
      currentIndex: _selectedIndex ?? 0,
      selectedItemColor: Colors.green[800],
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }
}
