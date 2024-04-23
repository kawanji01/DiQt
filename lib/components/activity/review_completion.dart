import 'package:booqs_mobile/i18n/translations.g.dart';
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
        color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold);

    Widget information() {
      if (activity.information == 'strict_mode') {
        return Text(
            t.activities.strict_review_completion(
              name: user.name,
            ),
            style: textBlack);
      }
      return Text(
          t.activities.review_completion(
            name: user.name,
          ),
          style: textBlack);
    }

    Widget continuationCount() {
      if (activity.continuationCount! < 2) {
        return Container();
      }
      return Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
            t.activities.continuous_review_completion(
                number: '${activity.continuationCount}'),
            style: textBlack),
      );
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
