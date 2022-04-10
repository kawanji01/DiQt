import 'package:badges/badges.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/home.dart';
import 'package:booqs_mobile/pages/notification/index.dart';
import 'package:booqs_mobile/pages/review/index.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavbar extends ConsumerStatefulWidget {
  const BottomNavbar({Key? key, required this.selectedIndex}) : super(key: key);

  final int selectedIndex;
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends ConsumerState<BottomNavbar> {
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  // 通知アイコンの生成
  Widget _buildNotificationIcon(User? user) {
    final int counter = user == null ? 0 : user.unreadNotificationsCount;
    if (counter == 0) {
      return const Icon(Icons.notifications);
    }

    String counterStr;
    if (counter > 99) {
      counterStr = '+99';
    } else {
      counterStr = '$counter';
    }

    return Badge(
      badgeContent: Text(
        counterStr,
        style: const TextStyle(color: Colors.white),
      ),
      child: const Icon(Icons.notifications),
    );
  }

  // 復習アイコンの生成
  Widget _buildReviewIcon(User? user) {
    final int counter = user == null ? 0 : user.unsolvedReviewsCount;

    if (counter == 0) {
      return const Icon(Icons.access_alarm);
    }

    String counterStr;
    if (counter > 99) {
      counterStr = '+99';
    } else {
      counterStr = '$counter';
    }
    return Badge(
      badgeContent: Text(
        counterStr,
        style: const TextStyle(color: Colors.white),
      ),
      child: const Icon(Icons.access_alarm),
    );
  }

  // 参考：https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html
  void _onItemTapped(int index) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    switch (index) {
      case 0:
        MyHomePage.push(context);
        break;
      case 1:
        if (_selectedIndex == index) return;
        ReviewIndexPage.push(context);
        break;
      case 2:
        if (_selectedIndex == index) return;
        NotificationIndexPage.push(context);
        break;
      case 3:
        if (_selectedIndex == index) return;
        UserMyPage.push(context);
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '辞書',
        ),
        BottomNavigationBarItem(
          icon: _buildReviewIcon(user),
          label: '復習',
        ),
        BottomNavigationBarItem(
          icon: _buildNotificationIcon(user),
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
