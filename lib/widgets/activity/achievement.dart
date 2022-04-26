import 'dart:io';

import 'package:booqs_mobile/models/achievement.dart';
import 'package:booqs_mobile/models/activity.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/achievements.dart';
import 'package:booqs_mobile/widgets/user/feed_icon.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ActivityAchievement extends StatelessWidget {
  const ActivityAchievement({Key? key, required this.activity})
      : super(key: key);
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    final User user = activity.user!;
    final Achievement achievement = activity.achievement!;
    final File file = File(achievement.imageUrl);
    final filename = basename(file.path);
    final achievementImageUrl =
        "https://res.cloudinary.com/hkbyf3jop/image/upload/c_scale,w_2.5,l_achievements:$filename/v1587185448/halo_rainbow.png";

    final Widget information = RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: user.name,
              style: const TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const TextSpan(
              text: 'が',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.normal)),
          const WidgetSpan(
            child: Icon(
              Icons.emoji_events,
              color: Colors.green,
              size: 18.0,
            ),
          ),
          TextSpan(
              text: ' ${achievement.name}メダル',
              style: const TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const TextSpan(
              text: 'を獲得しました！！',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.normal)),
        ],
      ),
    );

    final Widget message = Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Row(
        children: [
          UserFeedIcon(user: user),
          Expanded(
            child: information,
          ),
        ],
      ),
    );

    Widget _achievementImage() {
      return InkWell(
        onTap: () {
          UserAchievementsPage.pushDialog(context, user);
        },
        child: Image.network(achievementImageUrl),
      );
    }

    return Column(
      children: [
        message,
        _achievementImage(),
      ],
    );
  }
}
