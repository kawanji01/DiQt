import 'package:badges/badges.dart';
import 'package:booqs_mobile/data/provider/bottom_navbar_state.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/chapter/index.dart';
import 'package:booqs_mobile/pages/home.dart';
import 'package:booqs_mobile/pages/notice/home.dart';
import 'package:booqs_mobile/pages/review/index.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavbar extends ConsumerWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? _user = ref.watch(currentUserProvider);
    final int _selectedIndex = ref.watch(bottomNavbarState);

    // 通知アイコンの生成
    Widget _buildNotificationIcon(User? user) {
      final int counter = user == null ? 0 : user.unreadNotificationsCount;
      if (user == null) {
        return const Icon(Icons.notifications);
      }

      String counterStr;
      if (counter > 99) {
        counterStr = '+99';
      } else {
        counterStr = '$counter';
      }

      // 未受領の実績メダルがあるなら、それを伝える
      if (user.rewardRemained) {
        return Badge(
          badgeContent: const Icon(
            Icons.emoji_events,
            color: Colors.white,
          ),
          child: const Icon(Icons.notifications),
        );
      }

      if (counter == 0) {
        return const Icon(Icons.notifications);
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
          ChapterIndexPage.push(context);
          break;
        case 2:
          if (_selectedIndex == index) return;
          ReviewIndexPage.push(context);
          break;
        case 3:
          if (_selectedIndex == index) return;
          NoticeHomePage.push(context);
          break;
        case 4:
          if (_selectedIndex == index) return;
          UserMyPage.push(context);
          break;
      }
      ref.watch(bottomNavbarState.notifier).state = index;
    }

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '辞書',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.check),
          label: '単語帳',
        ),
        BottomNavigationBarItem(
          icon: _buildReviewIcon(_user),
          label: '復習',
        ),
        BottomNavigationBarItem(
          icon: _buildNotificationIcon(_user),
          label: '通知',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'マイページ',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.green[800],
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }
}
