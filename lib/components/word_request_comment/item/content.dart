import 'package:booqs_mobile/components/user/feed_icon.dart';
import 'package:booqs_mobile/components/word_request_comment/item/edit_buttons.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/models/word_request_comment.dart';
import 'package:flutter/material.dart';

class WordRequestCommentItemContent extends StatelessWidget {
  const WordRequestCommentItemContent(
      {super.key, required this.wordRequestComment, required this.editPressed});
  final WordRequestComment wordRequestComment;
  final VoidCallback editPressed;

  @override
  Widget build(BuildContext context) {
    final User? user = wordRequestComment.user;
    if (user == null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: const Text(
          'Deleted User',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      );
    }

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
                  user.name,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  wordRequestComment.body,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                WordRequestCommentItemEditButtons(
                    wordRequestComment: wordRequestComment,
                    editPressed: editPressed),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
