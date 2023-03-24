import 'package:badges/badges.dart' as badges;
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';

class BottomNavbarReviewIcon extends StatelessWidget {
  const BottomNavbarReviewIcon({Key? key, required this.user})
      : super(key: key);
  final User? user;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Icon(Icons.access_alarm);
    }
    final int counter = user?.unsolvedReviewsCount ?? 0;

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
