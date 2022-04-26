import 'package:booqs_mobile/models/notice.dart';
import 'package:booqs_mobile/widgets/notice/achievement.dart';
import 'package:booqs_mobile/widgets/notice/achievement_for_followers.dart';
import 'package:booqs_mobile/widgets/notice/cheering.dart';
import 'package:booqs_mobile/widgets/activity/continuous_answer.dart';
import 'package:booqs_mobile/widgets/notice/daily_goal.dart';
import 'package:booqs_mobile/widgets/notice/follow.dart';
import 'package:booqs_mobile/widgets/notice/monthly_report.dart';
import 'package:booqs_mobile/widgets/notice/weekly_report.dart';
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
      case 'follow':
        return NoticeFollow(notice: notice);
      case 'weekly_report':
        return NoticeWeeklyReport(notice: notice);
      case 'monthly_report':
        return NoticeMonthlyReport(notice: notice);
      case 'cheering':
        return NoticeCheering(notice: notice);
      /* case 'continuous_answer':
        return NoticeContinuousAnswer(notice: notice);
      case 'daily_goal':
        return NoticeDailyGoal(notice: notice);
     
      case 'achievement_for_followers':
        return NoticeAchievementForFollowers(notice: notice); */

      /* case 'accept_word_request':
          return NoticeContinuousAnswer(notice: notice);
        case 'approval_for_word_request':
          return NoticeContinuousAnswer(notice: notice);
        case 'cheering':
          return NoticeCheering(notice: notice);
        case 'inquiry_closed':
          return NoticeContinuousAnswer(notice: notice); */
      default:
        return Text(notifiedType);
    }
  }
}
