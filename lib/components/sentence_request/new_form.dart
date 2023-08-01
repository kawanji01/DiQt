import 'package:booqs_mobile/components/form/gray_text_form_field.dart';
import 'package:booqs_mobile/data/provider/sentence_request.dart';
import 'package:booqs_mobile/data/remote/sentence_request_comments.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceRequestCommentNewForm extends ConsumerStatefulWidget {
  const SentenceRequestCommentNewForm(
      {super.key,
      required this.sentenceRequest,
      required this.commentController});
  final SentenceRequest sentenceRequest;
  final TextEditingController commentController;

  @override
  SentenceRequestCommentNewFormState createState() =>
      SentenceRequestCommentNewFormState();
}

class SentenceRequestCommentNewFormState
    extends ConsumerState<SentenceRequestCommentNewForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isRequesting = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _isRequesting = true);
    EasyLoading.show();
    final Map resMap = await RemoteSentenceRequestComments.create(
      sentenceRequestId: widget.sentenceRequest.id,
      text: widget.commentController.text,
      appliedDictionaryId: widget.sentenceRequest.dictionaryId,
    );
    EasyLoading.dismiss();
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      ErrorHandler.showErrorToast(context, resMap);
      setState(() => _isRequesting = false);
      return;
    }
    setState(() => _isRequesting = false);
    ref.invalidate(
        asyncSentenceRequestCommentsFamily(widget.sentenceRequest.id));
    widget.commentController.clear();
    Toasts.showSimple(context, t.shared.create_succeeded);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.only(bottom: 32),
        color: Colors.white,
        child: Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: FormGrayTextFormField(
                    controller: widget.commentController,
                    label: t.wordRequestComments.comment_placeholder,
                    emptyValidationText: t.errors.cant_be_blank,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  decoration: const BoxDecoration(
                    color: Colors.green, // 背景色を緑に設定
                    shape: BoxShape.circle, // オプションで丸い形状に
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, size: 24), // 使用したいアイコン
                    onPressed: _isRequesting ? null : _submit,
                    color: Colors.white, // アイコンの色
                    tooltip: t.wordRequestComments.send, // ツールチップ（オプション）
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
