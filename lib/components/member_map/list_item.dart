import 'package:booqs_mobile/components/user/feed_icon.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/member_map.dart';
import 'package:booqs_mobile/models/school.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';

class MemberMapListItem extends StatelessWidget {
  const MemberMapListItem({super.key, required this.memberMap});
  final MemberMap memberMap;

  @override
  Widget build(BuildContext context) {
    final User? user = memberMap.user;
    final School? school = memberMap.school;
    if (user == null) {
      return Container();
    }
    if (school == null) {
      return Container();
    }

    Widget info() {
      const style = TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54);
      if (school.userId == user.id) {
        return Text(
          t.schools.owner,
          style: style,
        );
      }
      if (memberMap.admin) {
        return Text(t.schools.admin, style: style);
      }
      if (memberMap.moderator) {
        return Text(t.schools.moderator, style: style);
      }
      return Text(t.schools.member, style: style);
    }

    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Row(
        children: [
          UserFeedIcon(user: user),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                info(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
