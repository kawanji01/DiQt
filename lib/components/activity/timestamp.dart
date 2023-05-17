import 'package:booqs_mobile/models/activity.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:flutter/material.dart';

class ActivityTimestamp extends StatelessWidget {
  const ActivityTimestamp({Key? key, required this.activity}) : super(key: key);
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    final timeAgoString =
        DateTimeFormatter.createTimeAgoString(activity.createdAt);

    return Container(
        alignment: Alignment.centerRight, child: Text(timeAgoString));
  }
}
