import 'package:booqs_mobile/components/shared/timestamp.dart';
import 'package:booqs_mobile/components/user/feed_icon.dart';
import 'package:booqs_mobile/components/word_request/list_item.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/notice.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';

class NoticeWordRequestUpvoted extends StatelessWidget {
  const NoticeWordRequestUpvoted({super.key, required this.notice});
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final WordRequest? wordRequest = notice.wordRequest;
    if (wordRequest == null) {
      return Text(t.shared.no_items_found(name: t.wordRequests.word_requests));
    }
    final User? user = wordRequest.user;
    if (user == null) {
      return Text(t.shared.no_items_found(name: t.users.user));
    }
    final User? notifying = notice.notifying;
    if (notifying == null) {
      return Text(t.shared.no_items_found(name: t.users.user));
    }

    return Column(
      children: [
        SharedTimestamp(timestamp: notice.createdAt),
        // message
        Container(
          padding: const EdgeInsets.only(top: 16, bottom: 24),
          child: Row(
            children: [
              UserFeedIcon(user: user),
              Expanded(
                child: Text(
                  t.notices.word_request_upvoted_message(name: notifying.name),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding:
              const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.black26)),
          child: WordRequestListItem(
            wordRequest: wordRequest,
          ),
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}
