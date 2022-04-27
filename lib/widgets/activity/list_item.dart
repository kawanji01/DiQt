import 'package:booqs_mobile/models/activity.dart';
import 'package:booqs_mobile/models/cheer.dart';
import 'package:booqs_mobile/widgets/activity/cheer_button.dart';
import 'package:booqs_mobile/widgets/activity/information.dart';
import 'package:booqs_mobile/widgets/activity/timestamp.dart';
import 'package:flutter/material.dart';

class ActivityListItem extends StatelessWidget {
  const ActivityListItem({Key? key, required this.activity}) : super(key: key);
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    final Cheer? cheer = activity.cheer;
    return Column(
      children: [
        ActivityTimestamp(activity: activity),
        ActivityInformation(activity: activity),
        const SizedBox(height: 8),
        ActivityCheerButton(
          activity: activity,
          cheer: cheer,
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}
