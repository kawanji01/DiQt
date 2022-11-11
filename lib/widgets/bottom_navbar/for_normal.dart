import 'package:booqs_mobile/data/provider/bottom_navbar_state.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/home/home_page.dart';
import 'package:booqs_mobile/pages/notice/home.dart';
import 'package:booqs_mobile/pages/review/index.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/widgets/bottom_navbar/notification_icon.dart';
import 'package:booqs_mobile/widgets/bottom_navbar/review_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavbarForNormal extends ConsumerWidget {
  const BottomNavbarForNormal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? _user = ref.watch(currentUserProvider);
    int _selectedIndex = ref.watch(bottomNavbarState);
    // 教室プラン加入者がログアウトする時、マイページのindexが4になることによって発生するエラーを防ぐ。
    if (_selectedIndex > 3) {
      _selectedIndex = 3;
    }

    // 参考：https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html
    void _onItemTapped(int index) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      // ローディングがあれば消す
      EasyLoading.dismiss();
      switch (index) {
        case 0:
          HomePage.push(context);
          break;
        case 1:
          ReviewIndexPage.pushReplacement(context);
          break;
        case 2:
          NoticeHomePage.push(context, 0);
          break;
        case 3:
          UserMyPage.push(context);
          break;
      }
      ref.read(bottomNavbarState.notifier).state = index;
    }

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '辞書',
        ),
        BottomNavigationBarItem(
          icon: BottomNavbarReviewIcon(
            user: _user,
          ),
          label: '復習',
        ),
        BottomNavigationBarItem(
          icon: BottomNavbarNotificationIcon(
            user: _user,
          ),
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
