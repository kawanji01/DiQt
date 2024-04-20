import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/notice/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:badges/badges.dart' as badges;

class UserNotificationButton extends ConsumerWidget {
  const UserNotificationButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);

    if (user == null) {
      return Container(
        margin: const EdgeInsets.only(right: 16),
        child: IconButton(
          //iconSize: 28,
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),
      );
    }

    // 通知の数が０なら通常のアイコン
    final int counter = ref.watch(unreadNotificationsCountProvider);

    if (counter == 0) {
      return Container(
        margin: const EdgeInsets.only(right: 16),
        child: IconButton(
          // iconSize: 28,
          icon: const Icon(Icons.notifications),
          onPressed: () {
            NoticeHomePage.push(context, 0);
          },
        ),
      );
    }
    // 通知の数は99以上あれば、+99を表示する。
    String counterStr;
    if (counter > 99) {
      counterStr = '+99';
    } else {
      counterStr = '$counter';
    }
    return Container(
      margin: const EdgeInsets.only(right: 28, top: 6),
      child: badges.Badge(
        badgeContent: Text(
          counterStr,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        child: IconButton(
          icon: const Icon(Icons.notifications_active),
          onPressed: () {
            NoticeHomePage.push(context, 0);
          },
        ),
      ),
    );
  }
}
