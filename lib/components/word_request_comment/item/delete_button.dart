import 'package:booqs_mobile/components/shared/delete_confirmation.dart';
import 'package:booqs_mobile/data/provider/word_request.dart';
import 'package:booqs_mobile/data/remote/word_request_comments.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word_request_comment.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordRequestCommentItemDeleteButton extends ConsumerStatefulWidget {
  const WordRequestCommentItemDeleteButton(
      {super.key, required this.wordRequestComment});
  final WordRequestComment wordRequestComment;

  @override
  WordRequestCommentItemDeleteButtonState createState() =>
      WordRequestCommentItemDeleteButtonState();
}

class WordRequestCommentItemDeleteButtonState
    extends ConsumerState<WordRequestCommentItemDeleteButton> {
  // destroy
  Future<void> _destroy() async {
    EasyLoading.show();
    final Map resMap =
        await RemoteWordRequestComments.destroy(widget.wordRequestComment.id);
    EasyLoading.dismiss();
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      ErrorHandler.showErrorToast(context, resMap);
      return;
    }

    ref.invalidate(asyncWordRequestCommentsFamily(
        widget.wordRequestComment.wordRequestId));
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
