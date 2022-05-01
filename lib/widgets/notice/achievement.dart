import 'dart:io';

import 'package:booqs_mobile/models/achievement.dart';
import 'package:booqs_mobile/models/notice.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/achievements.dart';
import 'package:booqs_mobile/widgets/notice/timestamp.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class NoticeAchievement extends StatelessWidget {
  const NoticeAchievement({Key? key, required this.notice}) : super(key: key);
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final User user = notice.notifying!;
    final Achievement achievement = notice.achievement!;
    final File file = File(achievement.imageUrl);
    final filename = basename(file.path);
    final achievementImageUrl =
        "https://res.cloudinary.com/hkbyf3jop/image/upload/c_scale,w_2.5,l_achievements:$filename/v1587185448/halo_rainbow.png";

    final Widget information = RichText(
      text: TextSpan(
        children: [
          const WidgetSpan(
            child: Icon(
              Icons.military_tech,
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

    final Widget notifying = Container(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Row(
        children: [
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
        child: CachedNetworkImage(
          imageUrl: achievementImageUrl,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      );
    }

    return Column(
      children: [
        NoticeTimestamp(notice: notice),
        notifying,
        _achievementImage(),
        const SizedBox(height: 48),
      ],
    );
  }
}
