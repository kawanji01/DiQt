import 'package:booqs_mobile/components/sentence_request_comment/new_form.dart';
import 'package:booqs_mobile/components/sentence_request_comment/item_list.dart';
import 'package:booqs_mobile/data/provider/sentence_request.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceRequestItemCommentsScreen extends ConsumerStatefulWidget {
  const SentenceRequestItemCommentsScreen(
      {super.key,
      required this.sentenceRequest,
      required this.commentController});
  final SentenceRequest sentenceRequest;
  final TextEditingController commentController;

  @override
  SentenceRequestItemCommentsScreenState createState() =>
      SentenceRequestItemCommentsScreenState();
}

class SentenceRequestItemCommentsScreenState
    extends ConsumerState<SentenceRequestItemCommentsScreen> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(
          asyncSentenceRequestCommentsFamily(widget.sentenceRequest.id));
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
              child: SentenceRequestCommentItemList(
                sentenceRequest: widget.sentenceRequest,
              ),
            ),
            SentenceRequestCommentNewForm(
              sentenceRequest: widget.sentenceRequest,
              commentController: widget.commentController,
            ),
          ],
        ),
      ),
    );
  }
}
