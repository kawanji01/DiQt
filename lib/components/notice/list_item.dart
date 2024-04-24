import 'package:booqs_mobile/components/notice/quiz_request_accepted.dart';
import 'package:booqs_mobile/components/notice/quiz_request_commented.dart';
import 'package:booqs_mobile/components/notice/quiz_request_upvoted.dart';
import 'package:booqs_mobile/components/notice/sentence_request_accepted.dart';
import 'package:booqs_mobile/components/notice/sentence_request_commented.dart';
import 'package:booqs_mobile/components/notice/sentence_request_upvoted.dart';
import 'package:booqs_mobile/components/notice/word_request_accepted.dart';
import 'package:booqs_mobile/components/notice/word_request_commented.dart';
import 'package:booqs_mobile/components/notice/word_request_upvoted.dart';
import 'package:booqs_mobile/models/notice.dart';
import 'package:booqs_mobile/components/notice/achievement.dart';
import 'package:booqs_mobile/components/notice/cheered.dart';
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
      case 'cheered':
        return NoticeCheered(notice: notice);
      case 'word_request_accepted':
        return NoticeWordRequestAccepted(notice: notice);
      case 'word_request_commented':
        return NoticeWordRequestCommented(notice: notice);
      case 'word_request_upvoted':
        return NoticeWordRequestUpvoted(notice: notice);
      case 'sentence_request_accepted':
        return NoticeSentenceRequestAccepted(notice: notice);
      case 'sentence_request_commented':
        return NoticeSentenceRequestCommented(notice: notice);
      case 'sentence_request_upvoted':
        return NoticeSentenceRequestUpvoted(notice: notice);
      case 'quiz_request_accepted':
        return NoticeQuizRequestAccepted(notice: notice);
      case 'quiz_request_commented':
        return NoticeQuizRequestCommented(notice: notice);
      case 'quiz_request_upvoted':
        return NoticeQuizRequestUpvoted(notice: notice);
      default:
        return Text(notifiedType);
    }
  }
}
