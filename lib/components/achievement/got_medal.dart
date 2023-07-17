import 'package:booqs_mobile/models/achievement.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AchievementGotMedal extends StatelessWidget {
  const AchievementGotMedal(
      {super.key, required this.achievement, required this.width});
  final Achievement achievement;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(children: <Widget>[
        CachedNetworkImage(
          imageUrl: achievement.imageUrl,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(achievement.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87))),
      ]),
    );
  }
}
