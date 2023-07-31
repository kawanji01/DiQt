import 'package:booqs_mobile/components/word_request_comment/item/content.dart';
import 'package:booqs_mobile/components/word_request_comment/item/edit_form.dart';
import 'package:booqs_mobile/data/remote/word_request_comments.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word_request_comment.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordRequestCommentItem extends ConsumerStatefulWidget {
  const WordRequestCommentItem({super.key, required this.wordRequestComment});
  final WordRequestComment wordRequestComment;

  @override
  WordRequestCommentItemState createState() => WordRequestCommentItemState();
}

class WordRequestCommentItemState
    extends ConsumerState<WordRequestCommentItem> {
  late WordRequestComment wordRequestComment;
  final TextEditingController _commentController = TextEditingController();
  bool _isEdit = false;
  bool _isRequesting = false;

  @override
  void initState() {
    super.initState();
    wordRequestComment = widget.wordRequestComment;
    _commentController.text = wordRequestComment.body;
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  Future<void> _save() async {
    EasyLoading.show();
    final Map resMap = await RemoteWordRequestComments.update(
        wordRequestCommentId: wordRequestComment.id,
        text: _commentController.text);
    EasyLoading.dismiss();
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      ErrorHandler.showErrorToast(context, resMap);
      setState(() {
        _isEdit = false;
        _isRequesting = false;
      });
      return;
    }
    wordRequestComment =
        WordRequestComment.fromJson(resMap['word_request_comment']);
    setState(() {
      _isEdit = false;
      _isRequesting = false;
      wordRequestComment;
    });
    Toasts.showSimple(context, t.shared.create_succeeded);
  }

  @override
  Widget build(BuildContext context) {
    if (_isEdit) {
      return WordRequestCommentItemEditForm(
          wordRequestComment: wordRequestComment,
          commentController: _commentController,
          onSave: () {
            if (_isRequesting) return;
            _save();
          });
    }

    return WordRequestCommentItemContent(
      wordRequestComment: wordRequestComment,
      editPressed: () {
        _commentController.text = wordRequestComment.body;
        setState(() => _isEdit = true);
      },
    );
  }
}
