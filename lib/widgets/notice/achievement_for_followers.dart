import 'dart:io';
import 'package:booqs_mobile/models/achievement.dart';
import 'package:booqs_mobile/models/cheer.dart';
import 'package:booqs_mobile/models/notice.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/widgets/notice/timestamp.dart';
import 'package:booqs_mobile/widgets/user/feed_icon.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class NoticeAchievementForFollowers extends StatelessWidget {
  const NoticeAchievementForFollowers({Key? key, required this.notice})
      : super(key: key);
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final User user = notice.notifying!;
    final Achievement achievement = notice.achievement!;
    final Cheer? cheer = notice.cheer;
    //final String fileName = File(localFilePath).uri.pathSegments.last;
    final File _file = File(achievement.imageUrl);
    final filename = basename(_file.path);
    final achievementImageUrl =
        "https://res.cloudinary.com/hkbyf3jop/image/upload/c_scale,w_2.5,l_achievements:$filename/v1587185448/halo_rainbow.png";

    final Widget information = RichText(
        text: TextSpan(children: [
      TextSpan(
          text: user.name,
          style: const TextStyle(
              color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),
      const TextSpan(
          text: 'が',
          style: TextStyle(
              color: Colors.black,
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
              color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),
      const TextSpan(
          text: 'を獲得しました！！',
          style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.normal)),
    ]));

    final Widget notifying = Container(
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
      return Image.network(achievementImageUrl);
    }

    return Column(
      children: [
        NoticeTimestamp(notice: notice),
        notifying,
        _achievementImage(),
        const SizedBox(height: 8),
        const SizedBox(height: 48),
      ],
    );
  }
}
