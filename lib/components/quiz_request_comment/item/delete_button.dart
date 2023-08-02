import 'package:booqs_mobile/components/shared/delete_confirmation.dart';
import 'package:booqs_mobile/data/provider/quiz_request.dart';
import 'package:booqs_mobile/data/remote/quiz_request_comments.dart';
import 'package:booqs_mobile/data/remote/sentence_request_comments.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz_request_comment.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizRequestCommentItemDeleteButton extends ConsumerStatefulWidget {
  const QuizRequestCommentItemDeleteButton(
      {super.key, required this.quizRequestComment});
  final QuizRequestComment quizRequestComment;

  @override
  QuizRequestCommentItemDeleteButtonButtonState createState() =>
      QuizRequestCommentItemDeleteButtonButtonState();
}

class QuizRequestCommentItemDeleteButtonButtonState
    extends ConsumerState<QuizRequestCommentItemDeleteButton> {
  // destroy
  Future<void> _destroy() async {
    EasyLoading.show();
    final Map resMap =
        await RemoteQuizRequestComments.destroy(widget.quizRequestComment.id);
    EasyLoading.dismiss();
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      ErrorHandler.showErrorToast(context, resMap);
      return;
    }

    ref.invalidate(asyncQuizRequestCommentsFamily(
        widget.quizRequestComment.quizRequestId));
    Toasts.showSimple(context, t.shared.destroy_succeeded);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          final Widget screen = SharedDeleteConfirmation(
            onDeletePressed: _destroy,
          );
          Dialogs.slideFromBottomFade(screen);
        },
        child: Text(t.shared.destroy,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
                decoration: TextDecoration.underline)));
  }
}
