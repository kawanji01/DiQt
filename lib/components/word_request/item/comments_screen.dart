import 'package:booqs_mobile/components/word_request_comment/item_list.dart';
import 'package:booqs_mobile/data/provider/word_request.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../word_request_comment/new_form.dart';

class WordRequestItemCommentsScreen extends ConsumerStatefulWidget {
  const WordRequestItemCommentsScreen(
      {super.key, required this.wordRequest, required this.commentController});
  final WordRequest wordRequest;
  final TextEditingController commentController;

  @override
  WordRequestItemCommentsScreenState createState() =>
      WordRequestItemCommentsScreenState();
}

class WordRequestItemCommentsScreenState
    extends ConsumerState<WordRequestItemCommentsScreen> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(asyncWordRequestCommentsFamily(widget.wordRequest.id));
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
              child: WordRequestCommentItemList(
                wordRequest: widget.wordRequest,
              ),
            ),
            WordRequestCommentNewForm(
              wordRequest: widget.wordRequest,
              commentController: widget.commentController,
            ),
          ],
        ),
      ),
    );
  }
}
