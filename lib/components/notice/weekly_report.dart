import 'package:booqs_mobile/components/shared/timestamp.dart';
import 'package:booqs_mobile/models/notice.dart';
import 'package:booqs_mobile/models/weekly_report.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoticeWeeklyReport extends StatelessWidget {
  const NoticeWeeklyReport({Key? key, required this.notice}) : super(key: key);
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    if (notice.weeklyReport == null) {
      return Text(('InvalidNotification: ID:${notice.id}'));
    }
    final WeeklyReport weeklyReport = notice.weeklyReport!;
    final firstDateFormat = DateFormat('yyyy年MM月dd日');
    final String firstDate = firstDateFormat.format(
        DateTimeFormatter.findFirstDateOfTheWeek(weeklyReport.measuredDate));
    final lastDateFormat = DateFormat('MM月dd日');
    final String lastDate = lastDateFormat.format(
        DateTimeFormatter.findLastDateOfTheWeek(weeklyReport.measuredDate));

    final int answersCount = weeklyReport.answersCount;

    final Widget messageText = RichText(
      text: TextSpan(
        children: [
          const WidgetSpan(
            child: Icon(
              Icons.emoji_events,
              color: Colors.green,
              size: 18.0,
            ),
          ),
          const TextSpan(
              text: ' 【週報】',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: ' $firstDate ~ $lastDate',
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.normal)),
        ],
      ),
    );

    final Widget message = Container(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Row(
        children: [
          Expanded(
            child: messageText,
          ),
        ],
      ),
    );

    Widget rankImage() {
      final String rankImageUrl =
          "https://res.cloudinary.com/hkbyf3jop/image/upload/l_text:Sawarabi%20Gothic_56_bold:${weeklyReport.rank}位,co_rgb:faf0a2,w_360,y_-32/v1589085558/ranking_weekly_gold.png";
      // if (report.rank == null || report.rank! > 100) return Container();

      //return Image.network(rankImageUrl);
      return CachedNetworkImage(
        imageUrl: rankImageUrl,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }

    Widget information(String label, String value) {
      return RichText(
          text: TextSpan(children: [
        TextSpan(
            text: '$label : ',
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.8)),
        TextSpan(
            text: value,
            style: const TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.8)),
      ]));
    }

    Widget rankInfo() {
      //if (report.rank == null || report.rank! > 100) return Container();
      const String label = '週間ランキング';
      final String value = '${weeklyReport.rank}位';
      return information(label, value);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedTimestamp(timestamp: notice.createdAt),
        message,
        rankImage(),
        const SizedBox(height: 8),
        rankInfo(),
        information('解答数', '$answersCount回'),
        const SizedBox(height: 48),
      ],
    );
  }
}
