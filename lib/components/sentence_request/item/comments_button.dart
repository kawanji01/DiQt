import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:booqs_mobile/components/sentence_request/item/comments_screen.dart';
import 'package:booqs_mobile/components/sentence_request/item/editor_comment.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';

class SentenceRequestItemCommentsButton extends StatefulWidget {
  const SentenceRequestItemCommentsButton(
      {super.key, required this.sentenceRequest});
  final SentenceRequest sentenceRequest;

  @override
  State<SentenceRequestItemCommentsButton> createState() =>
      SentenceRequestItemCommentsButtonState();
}

class SentenceRequestItemCommentsButtonState
    extends State<SentenceRequestItemCommentsButton> {
  // Screenを閉じても値が保持されるようにする
  final TextEditingController commentController = TextEditingController();

  @override
  dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SentenceRequest sentenceRequest = widget.sentenceRequest;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        // 編集者のコメント
        SentenceRequestItemEditorComment(
          sentenceRequest: sentenceRequest,
        ),
        const SizedBox(
          height: 8,
        ),
        // 編集
        // コメントボタン
        InkWell(
            child: SmallOutlineGrayButton(
              label:
                  '${t.wordRequests.comments}(${sentenceRequest.sentenceRequestCommentsCount})',
              icon: Icons.comment,
            ),
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  // 丸める
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                  ),
                  builder: (context) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              ResponsiveValues.horizontalMargin(context),
                          vertical: 32),
                      // keyboardにフォームが隠れないようにする。 ref: https://www.choge-blog.com/programming/flutter-keyboard-modalbottomsheet/
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      // 80%の高さで表示させる
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: SentenceRequestItemCommentsScreen(
                            sentenceRequest: sentenceRequest,
                            commentController: commentController),
                      ),
                    );
                  });
            }),
      ],
    );
  }
}
