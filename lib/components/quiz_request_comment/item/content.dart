import 'package:booqs_mobile/components/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/components/quiz_request_comment/item/edit_buttons.dart';
import 'package:booqs_mobile/components/user/feed_icon.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz_request_comment.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';

class QuizRequestCommentItemContent extends StatelessWidget {
  const QuizRequestCommentItemContent(
      {super.key, required this.quizRequestComment, required this.editPressed});
  final QuizRequestComment quizRequestComment;
  final VoidCallback editPressed;

  @override
  Widget build(BuildContext context) {
    final User? user = quizRequestComment.user;
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
                  text: quizRequestComment.body,
                  dictionaryId: quizRequestComment.dictionaryId,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontColor: Colors.black87,
                  selectable: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                QuizRequestCommentItemEditButtons(
                    quizRequestComment: quizRequestComment,
                    editPressed: editPressed),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
