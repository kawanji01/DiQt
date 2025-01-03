import 'dart:io';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/achievement.dart';
import 'package:booqs_mobile/models/activity.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/user/achievements.dart';
import 'package:booqs_mobile/components/user/feed_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';

class ActivityAchievement extends ConsumerWidget {
  const ActivityAchievement({super.key, required this.activity});
  final Activity activity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User user = activity.user!;
    final Achievement achievement = activity.achievement!;
    final File file = File(achievement.imageUrl);
    final filename = basename(file.path);
    final achievementImageUrl =
        "https://res.cloudinary.com/hkbyf3jop/image/upload/c_scale,w_2.3,l_achievements:$filename/v1587185448/halo_rainbow.png";
    final String? name = t['achievements.${achievement.i18nKey}_name'];

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 16, bottom: 24),
          child: Row(
            children: [
              UserFeedIcon(user: user),
              Expanded(
                  child: Text(
                t.activities
                    .achievement(name: user.name, achievement_name: '$name'),
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )),
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
      ],
    );
  }
}
