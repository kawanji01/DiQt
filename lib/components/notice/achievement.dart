import 'dart:io';
import 'package:booqs_mobile/components/shared/timestamp.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/achievement.dart';
import 'package:booqs_mobile/models/notice.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/achievements.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';

class NoticeAchievement extends ConsumerWidget {
  const NoticeAchievement({Key? key, required this.notice}) : super(key: key);
  final Notice notice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User user = notice.notifying!;
    final Achievement achievement = notice.achievement!;
    final File file = File(achievement.imageUrl);
    final filename = basename(file.path);
    final achievementImageUrl =
        "https://res.cloudinary.com/hkbyf3jop/image/upload/c_scale,w_2.3,l_achievements:$filename/v1587185448/halo_rainbow.png";

    final String? name = t['achievements.${achievement.i18nKey}_name'];

    return Column(
      children: [
        SharedTimestamp(timestamp: notice.createdAt),
        Container(
          padding: const EdgeInsets.only(top: 16, bottom: 24),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  t.notices.achievement_acquired_message(name: '$name'),
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            ref.read(userProvider.notifier).state = user;
            UserAchievementsPage.pushDialog(context);
          },
          child: CachedNetworkImage(
            imageUrl: achievementImageUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}
