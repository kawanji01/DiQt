import 'package:booqs_mobile/components/shared/delete_confirmation_with_comment.dart';
import 'package:booqs_mobile/data/provider/shared.dart';
import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:booqs_mobile/pages/sentence/show.dart';
import 'package:booqs_mobile/pages/sentence_request/show.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceFormDestroyButton extends ConsumerStatefulWidget {
  const SentenceFormDestroyButton({super.key, required this.sentence});
  final Sentence sentence;

  @override
  ConsumerState<SentenceFormDestroyButton> createState() =>
      _SentenceFormDestroyButtonState();
}

class _SentenceFormDestroyButtonState
    extends ConsumerState<SentenceFormDestroyButton> {
  final _formKey = GlobalKey<FormState>();
  final _deleteCommentController = TextEditingController();

  @override
  void dispose() {
    _deleteCommentController.dispose();
    super.dispose();
  }

  Future<void> _destroy() async {
    if (!_formKey.currentState!.validate()) return;
    // ダイアログを閉じる。
    Navigator.of(context).pop();
    // 画面全体にローディングを表示
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteSentences.destroy(
        sentenceId: widget.sentence.id, comment: _deleteCommentController.text);
    EasyLoading.dismiss();
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      ErrorHandler.showErrorSnackBar(context, resMap);
      return;
    }
    final SentenceRequest sentenceRequest =
        SentenceRequest.fromJson(resMap['sentence_request']);
    final snackBar = SnackBar(content: Text(resMap['message']));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // 画面遷移を許可するために、編集中を解除する。
    ref.read(sharedEditingContentProvider.notifier).offEdit();

    if (sentenceRequest.closed()) {
      SentenceShowPage.pushReplacement(context, widget.sentence.id);
    } else {
      SentenceRequestShowPage.pushReplacement(context, sentenceRequest.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () {
          final Widget screen = SharedDeleteConfirmationWithComment(
              onDeletePressed: _destroy,
              formKey: _formKey,
              commentController: _deleteCommentController,
              emptyValidation: true);
          Dialogs.slideFromBottomFade(screen);
        },
        icon: const Icon(
          Icons.delete,
          size: 18,
          color: Colors.red,
        ),
        label: Text(t.shared.destroy,
            style: const TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.normal)),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.only(left: 0),
        ),
      ),
    );
  }
}
