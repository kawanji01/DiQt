import 'package:booqs_mobile/i18n/translations.g.dart';
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
    final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
    final String? name = t['achievements.${achievement.i18nKey}_name'];
    final String? introduction =
        t['achievements.${achievement.i18nKey}_introduction'];
    return SizedBox(
      width: width,
      child: Tooltip(
        key: tooltipkey,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        triggerMode: TooltipTriggerMode.manual,
        showDuration: const Duration(seconds: 1),
        message: '$introduction',
        child: Column(children: <Widget>[
          InkWell(
            onTap: () {
              tooltipkey.currentState?.ensureTooltipVisible();
            },
            child: CachedNetworkImage(
              imageUrl: achievement.imageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text('$name',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black87))),
        ]),
      ),
    );
  }
}
