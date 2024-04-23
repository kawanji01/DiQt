import 'package:booqs_mobile/components/button/small_green_button.dart';
import 'package:booqs_mobile/components/form/gray_multiline_field.dart';
import 'package:booqs_mobile/components/user/feed_icon.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence_request_comment.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';

class SentenceRequestCommentItemEditForm extends StatelessWidget {
  const SentenceRequestCommentItemEditForm(
      {super.key,
      required this.sentenceRequestComment,
      required this.commentController,
      required this.onSave});
  final SentenceRequestComment sentenceRequestComment;
  final TextEditingController commentController;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final User? user = sentenceRequestComment.user;
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
                FormGrayMultilineField(
                  hintText: t.wordRequestComments.comment_placeholder,
                  controller: commentController,
                ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: onSave,
                  child: SmallGreenButton(
                    icon: Icons.update,
                    label: t.shared.update,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
