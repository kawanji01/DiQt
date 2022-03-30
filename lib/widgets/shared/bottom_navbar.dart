import 'package:badges/badges.dart';
import 'package:booqs_mobile/pages/home.dart';
import 'package:booqs_mobile/pages/notification/index.dart';
import 'package:booqs_mobile/pages/review/index.dart';
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
  int _unsolvedReviewsCount = 0;
  int _unreadNotificationsCount = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _setCountToBadge();
  }

  // 復習と通知アイコンに表示するバッジのカウントを初期化する。
  Future _setCountToBadge() async {
    const storage = FlutterSecureStorage();
    String? unsolvedReviewsCount =
        await storage.read(key: 'unsolvedReviewsCount');
    String? unreadNotificationsCount =
        await storage.read(key: 'unreadNotificationsCount');

    setState(() {
      if (unsolvedReviewsCount == 'null' || unsolvedReviewsCount == null) {
        _unsolvedReviewsCount = 0;
      } else {
        _unsolvedReviewsCount = int.parse(unsolvedReviewsCount);
      }
      if (unreadNotificationsCount == 'null' ||
          unreadNotificationsCount == null) {
        _unreadNotificationsCount = 0;
      } else {
        _unreadNotificationsCount = int.parse(unreadNotificationsCount);
      }
    });
  }

  // 通知アイコンの生成
  Widget _buildNotificationIcon() {
    if (_unreadNotificationsCount == 0) {
      return const Icon(Icons.notifications);
    }

    String counter;
    if (_unreadNotificationsCount > 99) {
      counter = '+99';
    } else {
      counter = '$_unreadNotificationsCount';
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
  Widget _buildReviewIcon() {
    if (_unsolvedReviewsCount == 0) {
      return const Icon(Icons.access_alarm);
    }

    String counter;
    if (_unsolvedReviewsCount > 99) {
      counter = '+99';
    } else {
      counter = '$_unsolvedReviewsCount';
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
    //if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        MyHomePage.push(context);
        break;
      case 1:
        ReviewIndexPage.push(context);
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
          icon: _buildReviewIcon(),
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
