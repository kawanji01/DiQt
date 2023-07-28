import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:booqs_mobile/components/word/show_screen.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';

class RequestCommentListButton extends StatelessWidget {
  const RequestCommentListButton(
      {super.key, this.wordRequest, this.sentenceRequest, this.quizRequest});
  final WordRequest? wordRequest;
  final SentenceRequest? sentenceRequest;
  final QuizRequest? quizRequest;

  @override
  Widget build(BuildContext context) {
    int commentsCount = 0;
    if (wordRequest != null) {
      commentsCount = 0;
    } else if (sentenceRequest != null) {
      commentsCount = 0;
    } else if (quizRequest != null) {
      commentsCount = 0;
    }
    final Word? word = wordRequest?.word;
    if (word == null) {
      return Container();
    }
    return InkWell(
        child: SmallOutlineGrayButton(
          label: '${t.wordRequests.comments}($commentsCount)',
          icon: null,
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
                    horizontal: ResponsiveValues.horizontalMargin(context),
                  ),
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  // 80%の高さで表示させる
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: WordShowScreen(word: word),
                  ),
                );
              });
        });
  }
}
