import 'package:booqs_mobile/components/shared/timestamp.dart';
import 'package:booqs_mobile/components/word_request_comment/item.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/notice.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:booqs_mobile/models/word_request_comment.dart';
import 'package:booqs_mobile/pages/word_request/show.dart';
import 'package:flutter/material.dart';

class NoticeWordRequestCommented extends StatelessWidget {
  const NoticeWordRequestCommented({super.key, required this.notice});
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final WordRequest? wordRequest = notice.wordRequest;
    if (wordRequest == null) {
      return Text(t.shared.no_items_found(name: t.wordRequests.word_requests));
    }
    final WordRequestComment? wordRequestComment = notice.wordRequestComment;
    if (wordRequestComment == null) {
      return Text(t.shared.no_items_found(name: t.wordRequestComments.comment));
    }
    final User? user = wordRequest.user;
    if (user == null) {
      return Text(t.shared.no_items_found(name: t.users.user));
    }
    return Column(
      children: [
        SharedTimestamp(timestamp: notice.createdAt),
        // message
        Container(
          padding: const EdgeInsets.only(top: 16, bottom: 24),
          alignment: Alignment.centerLeft,
          child: Text(
            t.notices.word_request_commented_message,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
        ),
        InkWell(
          onTap: () {
            WordRequestShowPage.push(context, wordRequest.id);
          },
          child: Container(
            padding:
                const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.black26)),
            child: WordRequestCommentItem(
              wordRequestComment: wordRequestComment,
            ),
          ),
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}
