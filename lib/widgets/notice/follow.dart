import 'package:booqs_mobile/models/notice.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/widgets/notice/timestamp.dart';
import 'package:booqs_mobile/widgets/user/feed_icon.dart';
import 'package:flutter/material.dart';

class NoticeFollow extends StatelessWidget {
  const NoticeFollow({Key? key, required this.notice}) : super(key: key);
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final User user = notice.notifying!;

    final Widget information = RichText(
        text: TextSpan(children: [
      TextSpan(
          text: user.name,
          style: const TextStyle(
              color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),
      const TextSpan(
          text: 'があなたを',
          style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.normal)),
      const WidgetSpan(
        child: Icon(
          Icons.people,
          color: Colors.green,
          size: 18.0,
        ),
      ),
      const TextSpan(
          text: 'フォロー',
          style: TextStyle(
              color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),
      const TextSpan(
          text: 'しました。',
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
