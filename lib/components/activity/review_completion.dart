import 'package:booqs_mobile/models/activity.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/components/user/feed_icon.dart';
import 'package:flutter/material.dart';

class ActivityReviewCompletion extends StatelessWidget {
  const ActivityReviewCompletion({Key? key, required this.activity})
      : super(key: key);
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    final User user = activity.user!;

    const TextStyle textBlack = TextStyle(
        color: Colors.black87, fontSize: 16, fontWeight: FontWeight.normal);

    const TextStyle textGreen = TextStyle(
        color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold);

    final Widget information = RichText(
        text: TextSpan(children: [
      TextSpan(text: user.name, style: textGreen),
      const TextSpan(text: 'が', style: textBlack),
      const TextSpan(text: '復習', style: textGreen),
      const TextSpan(text: 'を', style: textBlack),
      TextSpan(
          text: activity.information == 'strict_mode' ? '厳格復習モードで' : '',
          style: textGreen),
      const TextSpan(text: '達成しました！', style: textBlack),
    ]));

    Widget continuationCount() {
      if (activity.continuationCount! < 2) {
        return Container();
      }
      return RichText(
          text: TextSpan(children: [
        TextSpan(text: '${activity.continuationCount}日連続', style: textGreen),
        const TextSpan(text: 'で達成しました！', style: textBlack),
      ]));
    }

    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Row(
        children: [
          UserFeedIcon(user: user),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                information,
                continuationCount(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
