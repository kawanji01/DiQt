import 'package:booqs_mobile/models/notice.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:flutter/material.dart';

class NoticeTimestamp extends StatelessWidget {
  const NoticeTimestamp({Key? key, required this.notice}) : super(key: key);
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final timeAgoString = createTimeAgoString(notice.createdAt);

    return Container(
        alignment: Alignment.centerRight, child: Text(timeAgoString));
  }
}
