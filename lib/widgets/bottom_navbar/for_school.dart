import 'package:booqs_mobile/data/provider/bottom_navbar_state.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/chapter/school.dart';
import 'package:booqs_mobile/pages/home/home_page.dart';
import 'package:booqs_mobile/pages/notice/home.dart';
import 'package:booqs_mobile/pages/review/index.dart';
import 'package:booqs_mobile/pages/user/mypage.dart';
import 'package:booqs_mobile/widgets/bottom_navbar/notification_icon.dart';
import 'package:booqs_mobile/widgets/bottom_navbar/review_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavbarForSchool extends ConsumerWidget {
  const BottomNavbarForSchool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? _user = ref.watch(currentUserProvider);
    final int _selectedIndex = ref.watch(bottomNavbarState);

    // 参考：https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html
    void _onItemTapped(int index) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      EasyLoading.dismiss();

      switch (index) {
        case 0:
          HomePage.push(context);
          break;
        case 1:
          ChapterSchoolPage.pushReplacement(context);
          break;
        case 2:
          //if (_selectedIndex == index) return;
          ReviewIndexPage.pushReplacement(context);
          break;
        case 3:
          //if (_selectedIndex == index) return;
          NoticeHomePage.push(context, 0);
          break;
        case 4:
          //if (_selectedIndex == index) return;
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
        const BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: '教室',
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
