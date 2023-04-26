import 'package:badges/badges.dart' as badges;
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavbarReviewIcon extends ConsumerWidget {
  const BottomNavbarReviewIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) {
      return const Icon(Icons.access_alarm);
    }
    final int counter = user.unsolvedReviewsCount;

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
        style: const TextStyle(color: Colors.white),
      ),
      child: const Icon(Icons.access_alarm),
    );
  }
}
