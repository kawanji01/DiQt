import 'package:booqs_mobile/components/shared/delete_confirmation.dart';
import 'package:booqs_mobile/data/provider/sentence_request.dart';
import 'package:booqs_mobile/data/remote/sentence_request_comments.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence_request_comment.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceRequestCommentItemDeleteButton extends ConsumerStatefulWidget {
  const SentenceRequestCommentItemDeleteButton(
      {super.key, required this.sentenceRequestComment});
  final SentenceRequestComment sentenceRequestComment;

  @override
  SentenceRequestCommentItemDeleteButtonState createState() =>
      SentenceRequestCommentItemDeleteButtonState();
}

class SentenceRequestCommentItemDeleteButtonState
    extends ConsumerState<SentenceRequestCommentItemDeleteButton> {
  // destroy
  Future<void> _destroy() async {
    EasyLoading.show();
    final Map resMap = await RemoteSentenceRequestComments.destroy(
        widget.sentenceRequestComment.id);
    EasyLoading.dismiss();
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      ErrorHandler.showErrorToast(context, resMap);
      return;
    }

    ref.invalidate(asyncSentenceRequestCommentsFamily(
        widget.sentenceRequestComment.sentenceRequestId));
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
