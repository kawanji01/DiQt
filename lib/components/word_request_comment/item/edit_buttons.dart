import 'package:booqs_mobile/components/word_request_comment/item/delete_button.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/models/word_request_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordRequestCommentItemEditButtons extends ConsumerWidget {
  const WordRequestCommentItemEditButtons(
      {super.key, required this.wordRequestComment, required this.editPressed});
  final WordRequestComment wordRequestComment;
  final VoidCallback editPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = wordRequestComment.user;
    final User? currentUser = ref.watch(currentUserProvider);
    if (user == null) {
      return Container();
    }
    if (currentUser?.id != user.id) {
      return Container();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: editPressed,
            child: Text(t.shared.edit,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                    decoration: TextDecoration.underline))),
        const SizedBox(
          width: 8,
        ),
        WordRequestCommentItemDeleteButton(
            wordRequestComment: wordRequestComment),
      ],
    );
  }
}
