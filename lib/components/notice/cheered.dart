import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/activity.dart';
import 'package:booqs_mobile/models/notice.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/components/activity/information.dart';
import 'package:booqs_mobile/components/notice/timestamp.dart';
import 'package:booqs_mobile/components/user/feed_icon.dart';
import 'package:flutter/material.dart';

class NoticeCheered extends StatelessWidget {
  const NoticeCheered({Key? key, required this.notice}) : super(key: key);
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final User user = notice.notifying!;
    final Activity activity = notice.activity!;

    final Widget message = Container(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Row(
        children: [
          UserFeedIcon(user: user),
          Expanded(
            child: Text(
              t.notices.cheered_message(name: user.name),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87),
            ),
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
