import 'package:booqs_mobile/components/quiz_request_comment/item/content.dart';
import 'package:booqs_mobile/components/quiz_request_comment/item/edit_form.dart';
import 'package:booqs_mobile/data/remote/quiz_request_comments.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz_request_comment.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizRequestCommentItem extends ConsumerStatefulWidget {
  const QuizRequestCommentItem({super.key, required this.quizRequestComment});
  final QuizRequestComment quizRequestComment;

  @override
  QuizRequestCommentItemState createState() => QuizRequestCommentItemState();
}

class QuizRequestCommentItemState
    extends ConsumerState<QuizRequestCommentItem> {
  late QuizRequestComment quizRequestComment;
  final TextEditingController _commentController = TextEditingController();
  bool _isEdit = false;
  bool _isRequesting = false;

  @override
  void initState() {
    super.initState();
    quizRequestComment = widget.quizRequestComment;
    _commentController.text = quizRequestComment.body;
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  Future<void> _save() async {
    EasyLoading.show();
    final Map resMap = await RemoteQuizRequestComments.update(
        quizRequestCommentId: quizRequestComment.id,
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
    quizRequestComment =
        QuizRequestComment.fromJson(resMap['quiz_request_comment']);
    setState(() {
      _isEdit = false;
      _isRequesting = false;
      quizRequestComment;
    });
    Toasts.showSimple(context, t.shared.create_succeeded);
  }

  @override
  Widget build(BuildContext context) {
    if (_isEdit) {
      return QuizRequestCommentItemEditForm(
          quizRequestComment: quizRequestComment,
          commentController: _commentController,
          onSave: () {
            if (_isRequesting) return;
            _save();
          });
    }

    return QuizRequestCommentItemContent(
      quizRequestComment: quizRequestComment,
      editPressed: () {
        _commentController.text = quizRequestComment.body;
        setState(() => _isEdit = true);
      },
    );
  }
}
