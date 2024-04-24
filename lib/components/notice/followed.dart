import 'package:booqs_mobile/components/shared/timestamp.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/notice.dart';
import 'package:booqs_mobile/models/relationship.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/components/relationship/follow_button.dart';
import 'package:booqs_mobile/components/user/feed_icon.dart';
import 'package:flutter/material.dart';

class NoticeFollowed extends StatelessWidget {
  const NoticeFollowed({Key? key, required this.notice}) : super(key: key);
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final User user = notice.notifying!;
    final Relationship? relationship = notice.relationship;
    //
    final Widget message = Container(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Row(
        children: [
          UserFeedIcon(user: user),
          Expanded(
            child: Text(
              t.notices.followed_message(name: user.name),
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    // referenceの中のユーザー情報＆フォローバックボタン
    final userInfo = Container(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Row(
        children: [
          UserFeedIcon(user: user),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  user.profile ?? '',
                  style: const TextStyle(color: Colors.black87, fontSize: 14),
                ),
                const SizedBox(
                  height: 8,
                ),
                RelationshipFollowButton(
                  user: user,
                  relationship: relationship,
                ),
              ],
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
      child: userInfo,
    );

    return Column(
      children: [
        SharedTimestamp(timestamp: notice.createdAt),
        message,
        reference,
        const SizedBox(height: 48),
      ],
    );
  }
}
