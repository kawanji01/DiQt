import 'package:booqs_mobile/models/monthly_report.dart';
import 'package:booqs_mobile/models/notice.dart';
import 'package:booqs_mobile/components/notice/timestamp.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoticeMonthlyReport extends StatelessWidget {
  const NoticeMonthlyReport({Key? key, required this.notice}) : super(key: key);
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    //
    if (notice.monthlyReport == null) {
      return Text(('InvalidNotification: ID:${notice.id}'));
    }

    final MonthlyReport monthlyReport = notice.monthlyReport!;
    DateTime? measuredDate = monthlyReport.measuredAt;
    measuredDate ??= monthlyReport.measuredDate;
    if (measuredDate == null) {
      return Container();
    }

    final dateFormat = DateFormat('yyyy年MM月');
    final String firstDate = dateFormat.format(measuredDate);

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
              text: ' 【月報】',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: ' $firstDate',
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

    Widget rankImage() {
      final String rankImageUrl =
          "https://res.cloudinary.com/hkbyf3jop/image/upload/l_text:Sawarabi%20Gothic_56_bold:${monthlyReport.rank}位,co_rgb:faf0a2,w_360,y_-32/v1589085558/ranking_monthly_gold.png";
      //if (report.rank == null || report.rank! > 100) return Container();
      return CachedNetworkImage(
        imageUrl: rankImageUrl,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }

    Widget rankInfo() {
      //if (report.rank == null || report.rank! > 100) return Container();

      const String label = '月間ランキング';
      final String value = '${monthlyReport.rank}位';
      return information(label, value);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NoticeTimestamp(notice: notice),
        message,
        rankImage(),
        const SizedBox(height: 8),
        rankInfo(),
        information('解答数', '${monthlyReport.numberOfAnswers}回'),
        //_information('解答日数', '${report.daysAnswered}日'),
        const SizedBox(height: 48),
      ],
    );
  }
}
