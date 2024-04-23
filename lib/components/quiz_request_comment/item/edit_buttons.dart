import 'package:booqs_mobile/components/quiz_request_comment/item/delete_button.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz_request_comment.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizRequestCommentItemEditButtons extends ConsumerWidget {
  const QuizRequestCommentItemEditButtons(
      {super.key, required this.quizRequestComment, required this.editPressed});
  final QuizRequestComment quizRequestComment;
  final VoidCallback editPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = quizRequestComment.user;
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
        QuizRequestCommentItemDeleteButton(
            quizRequestComment: quizRequestComment),
      ],
    );
  }
}
