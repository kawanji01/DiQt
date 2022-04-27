import 'package:booqs_mobile/models/activity.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/widgets/activity/achievement.dart';
import 'package:booqs_mobile/widgets/activity/continuous_answer.dart';
import 'package:booqs_mobile/widgets/activity/daily_goal.dart';
import 'package:flutter/material.dart';

class ActivityInformation extends StatelessWidget {
  const ActivityInformation({Key? key, required this.activity})
      : super(key: key);
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    final User? user = activity.user;
    if (user == null) return const Text('activity.user is null');

    final String activityType = activity.activityType;

    switch (activityType) {
      case 'continuous_answer':
        return ActivityContinuousAnswer(
          activity: activity,
        );
      case 'daily_goal':
        return ActivityDailyGoal(activity: activity);
      case 'achievement':
        return ActivityAchievement(activity: activity);
      default:
        return Text(activityType);
    }
  }
}
