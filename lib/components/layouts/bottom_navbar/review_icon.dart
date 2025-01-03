import 'package:badges/badges.dart' as badges;
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavbarReviewIcon extends ConsumerWidget {
  const BottomNavbarReviewIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int counter = ref.watch(unsolvedReviewsCountProvider);

    if (counter == 0) {
      return const Icon(Icons.access_alarm);
    }

    String counterStr;
    if (counter > 99) {
      counterStr = '+99';
    } else {
      counterStr = '$counter';
    }
    return badges.Badge(
      badgeContent: Text(
        counterStr,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      child: const Icon(Icons.access_alarm),
    );
  }
}
