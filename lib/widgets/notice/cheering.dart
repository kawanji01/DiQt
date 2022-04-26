import 'package:booqs_mobile/models/activity.dart';
import 'package:booqs_mobile/models/notice.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/widgets/activity/information.dart';
import 'package:booqs_mobile/widgets/notice/timestamp.dart';
import 'package:booqs_mobile/widgets/user/feed_icon.dart';
import 'package:flutter/material.dart';

class NoticeCheering extends StatelessWidget {
  const NoticeCheering({Key? key, required this.notice}) : super(key: key);
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final User user = notice.notifying!;
    final Activity activity = notice.activity!;

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
          Icons.favorite,
          color: Colors.green,
          size: 18.0,
        ),
      ),
      const TextSpan(
          text: '応援',
          style: TextStyle(
              color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),
      const TextSpan(
          text: 'しました。',
          style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.normal)),
    ]));

    final Widget message = Container(
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

    final Widget reference = Container(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black26)),
      child: ActivityInformation(
        activity: activity,
      ),
    );

    return Column(
      children: [
        NoticeTimestamp(notice: notice),
        message,
        reference,
        const SizedBox(height: 48),
      ],
    );
  }
}
