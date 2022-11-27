import 'package:booqs_mobile/models/activity.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/widgets/user/feed_icon.dart';
import 'package:flutter/material.dart';

class ActivityGoalAchievement extends StatelessWidget {
  const ActivityGoalAchievement({Key? key, required this.activity})
      : super(key: key);
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    final User user = activity.user!;

    const TextStyle textBlack = TextStyle(
        color: Colors.black87, fontSize: 16, fontWeight: FontWeight.normal);

    const TextStyle textGreen = TextStyle(
        color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold);

    Widget information() {
      if (activity.information == 'strict_solving_mode') {
        return RichText(
            text: TextSpan(children: [
          TextSpan(text: user.name, style: textGreen),
          const TextSpan(text: 'が', style: textBlack),
          TextSpan(text: '厳格解答モードで目標（${activity.amount}問正解）', style: textGreen),
          const TextSpan(text: 'を達成しました！', style: textBlack),
        ]));
      }
      return RichText(
          text: TextSpan(children: [
        TextSpan(text: user.name, style: textGreen),
        const TextSpan(text: 'が', style: textBlack),
        TextSpan(text: '目標（${activity.amount}問）', style: textGreen),
        const TextSpan(text: 'を達成しました！', style: textBlack),
      ]));
    }

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
                information(),
                continuationCount(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
