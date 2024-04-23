import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/activity.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/components/user/feed_icon.dart';
import 'package:flutter/material.dart';

class ActivityFirstOfTheDay extends StatelessWidget {
  const ActivityFirstOfTheDay({Key? key, required this.activity})
      : super(key: key);
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    final User user = activity.user!;
    const TextStyle textBlack = TextStyle(
        color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold);

    Widget continuationCount() {
      if (activity.continuationCount! < 2) {
        return Container();
      }
      return Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
            t.activities
                .continuation_count(number: '${activity.continuationCount}'),
            style: textBlack),
      );
    }

    Widget allWeekContinuationCount() {
      if (activity.allWeekContinuationCount == null) {
        return Container();
      }
      return Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
            t.activities.all_week_continuation_count(
                number: '${activity.allWeekContinuationCount}'),
            style: textBlack),
      );
    }

    Widget allMonthContinuationCount() {
      if (activity.allMonthContinuationCount == null) {
        return Container();
      }
      return Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
            t.activities.all_month_continuation_count(
                number: '${activity.allMonthContinuationCount}'),
            style: textBlack),
      );
    }

    Widget allYearContinuationCount() {
      if (activity.allYearContinuationCount == null) {
        return Container();
      }
      return Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
            t.activities.all_year_continuation_count(
                number: '${activity.allYearContinuationCount}'),
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
                Text(
                    t.activities.answer_days(
                        name: user.name, number: '${activity.amount}'),
                    style: textBlack),
                continuationCount(),
                allWeekContinuationCount(),
                allMonthContinuationCount(),
                allYearContinuationCount()
              ],
            ),
          )
        ],
      ),
    );
  }
}
