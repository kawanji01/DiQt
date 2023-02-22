import 'package:booqs_mobile/models/notice.dart';
import 'package:booqs_mobile/components/notice/achievement.dart';
import 'package:booqs_mobile/components/notice/cheering.dart';
import 'package:booqs_mobile/components/notice/followed.dart';
import 'package:booqs_mobile/components/notice/monthly_report.dart';
import 'package:booqs_mobile/components/notice/weekly_report.dart';
import 'package:flutter/material.dart';

class NoticeListItem extends StatelessWidget {
  const NoticeListItem({Key? key, required this.notice}) : super(key: key);
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final String notifiedType = notice.notifiedType;

    switch (notifiedType) {
      case 'achievement':
        return NoticeAchievement(notice: notice);
      case 'followed':
        return NoticeFollowed(notice: notice);
      case 'weekly_report':
        return NoticeWeeklyReport(notice: notice);
      case 'monthly_report':
        return NoticeMonthlyReport(notice: notice);
      case 'cheering':
        return NoticeCheering(notice: notice);

      /* case 'accept_word_request':
          return NoticeContinuousAnswer(notice: notice);
        case 'approval_for_word_request':
          return NoticeContinuousAnswer(notice: notice);
        case 'inquiry_closed':
          return NoticeContinuousAnswer(notice: notice); */
      default:
        return Text(notifiedType);
    }
  }
}
