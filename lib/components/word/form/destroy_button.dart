import 'package:booqs_mobile/components/shared/delete_confirmation_with_comment.dart';
import 'package:booqs_mobile/data/provider/shared.dart';
import 'package:booqs_mobile/data/remote/words.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:booqs_mobile/pages/dictionary/show.dart';
import 'package:booqs_mobile/pages/word_request/show.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordFormDestroyButton extends ConsumerStatefulWidget {
  const WordFormDestroyButton({super.key, required this.word});
  final Word word;

  @override
  ConsumerState<WordFormDestroyButton> createState() =>
      WordFormDestroyButtonState();
}

class WordFormDestroyButtonState extends ConsumerState<WordFormDestroyButton> {
  final _formKey = GlobalKey<FormState>();
  final _deleteCommentController = TextEditingController();

  @override
  void dispose() {
    _deleteCommentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    // ダイアログを閉じる。
    Navigator.of(context).pop();
    EasyLoading.show(status: 'loading...');
    final Map resMap = await RemoteWords.destroy(
        wordId: widget.word.id, comment: _deleteCommentController.text);
    EasyLoading.dismiss();
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      ErrorHandler.showErrorToast(context, resMap);
      return;
    }
    Toasts.showSimple(context, '${resMap['message']}');
    final WordRequest wordRequest =
        WordRequest.fromJson(resMap['word_request']);

    // 画面遷移を許可するために、編集中を解除する。
    ref.read(sharedEditingContentProvider.notifier).offEdit();
    if (wordRequest.closed()) {
      DictionaryShowPage.pushReplacement(context, widget.word.dictionaryId);
    } else {
      WordRequestShowPage.pushReplacement(context, wordRequest.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () {
          final Widget screen = SharedDeleteConfirmationWithComment(
            onDeletePressed: _submit,
            formKey: _formKey,
            commentController: _deleteCommentController,
            emptyValidation: true,
          );
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
