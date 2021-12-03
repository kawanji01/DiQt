import 'package:badges/badges.dart';
import 'package:booqs_mobile/pages/home.dart';
import 'package:booqs_mobile/pages/notification/index.dart';
import 'package:booqs_mobile/pages/reminder/index.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key, required this.selectedIndex}) : super(key: key);

  final int selectedIndex;
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int? _selectedIndex;
  int _remindersCounter = 0;
  int _notificationsCounter = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _setCountToBadge();
  }

  // 復習と通知アイコンに表示するバッジのカウントを初期化する。
  Future _setCountToBadge() async {
    const storage = FlutterSecureStorage();
    String? remindersCounter = await storage.read(key: 'remindersCount');
    String? notificationsCounter =
        await storage.read(key: 'notificationsCount');

    setState(() {
      if (remindersCounter == 'null' || remindersCounter == null) {
        _remindersCounter = 0;
      } else {
        _remindersCounter = int.parse(remindersCounter);
      }
      if (notificationsCounter == 'null' || notificationsCounter == null) {
        _notificationsCounter = 0;
      } else {
        _notificationsCounter = int.parse(notificationsCounter);
      }
    });
  }

  // 通知アイコンの生成
  Widget _buildNotificationIcon() {
    if (_notificationsCounter == 0) {
      return const Icon(Icons.notifications);
    }

    String counter;
    if (_notificationsCounter > 99) {
      counter = '+99';
    } else {
      counter = '$_notificationsCounter';
    }

    return Badge(
      badgeContent: Text(
        counter,
        style: const TextStyle(color: Colors.white),
      ),
      child: const Icon(Icons.notifications),
    );
  }

  // 復習アイコンの生成
  Widget _buildReminderIcon() {
    if (_remindersCounter == 0) {
      return const Icon(Icons.access_alarm);
    }

    String counter;
    if (_remindersCounter > 999) {
      counter = '999';
    } else {
      counter = '$_remindersCounter';
    }
    return Badge(
      badgeContent: Text(
        counter,
        style: const TextStyle(color: Colors.white),
      ),
      child: const Icon(Icons.access_alarm),
    );
  }

  // 参考：https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html
  void _onItemTapped(int index) {
    // 現在のページのボタンを押した場合には、画面遷移せずreturnする。
    if (_selectedIndex == index) return;

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
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '辞書',
        ),
        BottomNavigationBarItem(
          icon: _buildReminderIcon(),
          label: '復習',
        ),
        BottomNavigationBarItem(
          icon: _buildNotificationIcon(),
          label: '通知',
        ),
        const BottomNavigationBarItem(
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
