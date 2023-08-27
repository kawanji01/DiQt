import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/activity.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/components/user/feed_icon.dart';
import 'package:flutter/material.dart';

class ActivityLevelUp extends StatelessWidget {
  const ActivityLevelUp({Key? key, required this.activity}) : super(key: key);
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    final User user = activity.user!;
    const TextStyle textBlack = TextStyle(
        color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold);

    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Row(
        children: [
          UserFeedIcon(user: user),
          Expanded(
            child: Text(
              t.activities
                  .level_up(name: user.name, number: '${activity.amount}'),
              style: textBlack,
            ),
          )
        ],
      ),
    );
  }
}
