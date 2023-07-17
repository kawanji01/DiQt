import 'package:booqs_mobile/components/user/drill_list_view.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';

class UserDrills extends StatelessWidget {
  const UserDrills({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    if (user.drillsCount == 0) {
      return Container();
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            '${t.users.drills}( ${user.drillsCount})',
            style: const TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          UserDrillListView(userUid: user.publicUid),
        ],
      ),
    );
  }
}
