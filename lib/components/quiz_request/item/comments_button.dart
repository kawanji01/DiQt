import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:booqs_mobile/components/quiz_request/item/comments_screen.dart';
import 'package:booqs_mobile/components/quiz_request/item/editor_comment.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';

class QuizRequestItemCommentsButton extends StatefulWidget {
  const QuizRequestItemCommentsButton({super.key, required this.quizRequest});
  final QuizRequest quizRequest;

  @override
  State<QuizRequestItemCommentsButton> createState() =>
      QuizRequestItemCommentsButtonState();
}

class QuizRequestItemCommentsButtonState
    extends State<QuizRequestItemCommentsButton> {
  // Screenを閉じても値が保持されるようにする
  final TextEditingController commentController = TextEditingController();

  @override
  dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final QuizRequest quizRequest = widget.quizRequest;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        // 編集者のコメント
        QuizRequestItemEditorComment(
          quizRequest: quizRequest,
        ),
        const SizedBox(
          height: 8,
        ),
        // 編集者の
        // コメントボタン
        InkWell(
            child: SmallOutlineGrayButton(
              label:
                  '${t.wordRequests.comments}(${quizRequest.quizRequestCommentsCount})',
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
                        child: QuizRequestItemCommentsScreen(
                            quizRequest: quizRequest,
                            commentController: commentController),
                      ),
                    );
                  });
            }),
      ],
    );
  }
}
