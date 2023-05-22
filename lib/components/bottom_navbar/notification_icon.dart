import 'package:badges/badges.dart' as badges;
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavbarNotificationIcon extends ConsumerWidget {
  const BottomNavbarNotificationIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 未受領の実績メダルがあるなら、それを伝える
    if (ref.watch(rewardRemainedProvider)) {
      return badges.Badge(
        badgeContent: const Icon(
          Icons.military_tech,
          color: Colors.white,
        ),
        child: const Icon(Icons.notifications),
      );
    }

    // 通知の数が０なら通常のアイコン
    final int counter = ref.watch(unreadNotificationsCountProvider);
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
