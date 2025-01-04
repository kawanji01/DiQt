import 'package:booqs_mobile/components/shared/timestamp.dart';
import 'package:booqs_mobile/models/activity.dart';
import 'package:booqs_mobile/models/cheer.dart';
import 'package:booqs_mobile/components/activity/cheer_button.dart';
import 'package:booqs_mobile/components/activity/information.dart';
import 'package:flutter/material.dart';

class ActivityListItem extends StatelessWidget {
  const ActivityListItem({super.key, required this.activity});
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    final Cheer? cheer = activity.cheer;
    return Column(
      children: [
        SharedTimestamp(timestamp: activity.createdAt),
        ActivityInformation(activity: activity),
        const SizedBox(height: 8),
        ActivityCheerButton(
          activity: activity,
          cheer: cheer,
        ),
        const SizedBox(height: 56),
      ],
    );
  }
}
