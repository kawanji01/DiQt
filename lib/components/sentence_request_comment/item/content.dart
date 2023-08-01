import 'package:booqs_mobile/components/sentence_request_comment/item/edit_buttons.dart';
import 'package:booqs_mobile/components/user/feed_icon.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence_request_comment.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';

class SentenceRequestCommentItemContent extends StatelessWidget {
  const SentenceRequestCommentItemContent(
      {super.key,
      required this.sentenceRequestComment,
      required this.editPressed});
  final SentenceRequestComment sentenceRequestComment;
  final VoidCallback editPressed;

  @override
  Widget build(BuildContext context) {
    final User? user = sentenceRequestComment.user;
    final String name = user?.name ?? t.users.deleted_user;

    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Row(
        children: [
          UserFeedIcon(user: user),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  sentenceRequestComment.body,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SentenceRequestCommentItemEditButtons(
                    sentenceRequestComment: sentenceRequestComment,
                    editPressed: editPressed),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
