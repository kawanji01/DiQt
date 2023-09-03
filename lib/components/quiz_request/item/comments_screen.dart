import 'package:booqs_mobile/components/quiz_request/new_form.dart';
import 'package:booqs_mobile/components/quiz_request_comment/item_list.dart';
import 'package:booqs_mobile/data/provider/quiz_request.dart';
import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizRequestItemCommentsScreen extends ConsumerStatefulWidget {
  const QuizRequestItemCommentsScreen(
      {super.key, required this.quizRequest, required this.commentController});
  final QuizRequest quizRequest;
  final TextEditingController commentController;

  @override
  QuizRequestItemCommentsScreenState createState() =>
      QuizRequestItemCommentsScreenState();
}

class QuizRequestItemCommentsScreenState
    extends ConsumerState<QuizRequestItemCommentsScreen> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(asyncQuizRequestCommentsFamily(widget.quizRequest.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // キーボードを閉じる
        FocusScopeNode currentFocus = FocusScope.of(context);
        // フォーカスがすでにない状況でunfocus()を呼び出すと、エラーが発生する可能性がある
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SizedBox(
        width: double.infinity,
        height: ResponsiveValues.dialogHeight(context),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: QuizRequestCommentItemList(
                quizRequest: widget.quizRequest,
              ),
            ),
            QuizRequestCommentNewForm(
              quizRequest: widget.quizRequest,
              commentController: widget.commentController,
            ),
          ],
        ),
      ),
    );
  }
}
