import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/components/user/feed_icon.dart';
import 'package:booqs_mobile/components/word_request_comment/item/edit_buttons.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
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
    final String name = user?.name ?? t.users.deleted_user;

    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                MarkdownWithDictLink(
                  text: wordRequestComment.body,
                  dictionaryId: wordRequestComment.dictionaryId,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontColor: Colors.black87,
                  selectable: true,
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
