import 'package:booqs_mobile/models/cheer.dart';
import 'package:booqs_mobile/models/notice.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/widgets/notice/timestamp.dart';
import 'package:booqs_mobile/widgets/user/feed_icon.dart';
import 'package:flutter/material.dart';

class NoticeDailyGoal extends StatelessWidget {
  const NoticeDailyGoal({Key? key, required this.notice}) : super(key: key);
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final User user = notice.notifying!;
    final Cheer? cheer = notice.cheer;

    final Widget information = RichText(
        text: TextSpan(children: [
      TextSpan(
          text: user.name,
          style: const TextStyle(
              color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),
      const TextSpan(
          text: 'が',
          style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.normal)),
      TextSpan(
          text: '１日の目標（${notice.information}問）',
          style: const TextStyle(
              color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),
      const TextSpan(
          text: 'を達成しました！',
          style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.normal)),
    ]));

    final Widget notifying = Container(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Row(
        children: [
          UserFeedIcon(user: user),
          Expanded(
            child: information,
          ),
        ],
      ),
    );

    return Column(
      children: [
        NoticeTimestamp(notice: notice),
        notifying,
        const SizedBox(height: 48),
      ],
    );
  }
}
