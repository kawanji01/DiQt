import 'package:badges/badges.dart' as badges;
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';

class BottomNavbarNotificationIcon extends StatelessWidget {
  const BottomNavbarNotificationIcon({Key? key, required this.user})
      : super(key: key);
  final User? user;

  @override
  Widget build(BuildContext context) {
    // ログインしていないなら通常のアイコン
    if (user == null) {
      return const Icon(Icons.notifications);
    }
    // 未受領の実績メダルがあるなら、それを伝える
    if (user!.rewardRemained) {
      return badges.Badge(
        badgeContent: const Icon(
          Icons.military_tech,
          color: Colors.white,
        ),
        child: const Icon(Icons.notifications),
      );
    }

    // 通知の数が０なら通常のアイコン
    final int counter = user?.unreadNotificationsCount ?? 0;
    if (counter == 0) {
      return const Icon(Icons.notifications);
    }

    // 通知の数は99以上あれば、+99を表示する。
    String counterStr;
    if (counter > 99) {
      counterStr = '+99';
    } else {
      counterStr = '$counter';
    }
    return badges.Badge(
      badgeContent: Text(
        counterStr,
        style: const TextStyle(color: Colors.white),
      ),
      child: const Icon(Icons.notifications),
    );
  }
}
