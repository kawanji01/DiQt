import 'package:booqs_mobile/components/quiz_request/item/comments_button.dart';
import 'package:booqs_mobile/components/quiz_request/item/destroy_button.dart';
import 'package:booqs_mobile/components/quiz_request/item/details_button.dart';
import 'package:booqs_mobile/components/quiz_request/item/edit_target_button.dart';
import 'package:booqs_mobile/components/quiz_request/item/main_content.dart';
import 'package:booqs_mobile/components/quiz_request/pending_wrapper.dart';
import 'package:booqs_mobile/components/quiz_request_vote/buttons.dart';
import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:flutter/material.dart';

class QuizRequestListItem extends StatelessWidget {
  const QuizRequestListItem(
      {super.key, required this.quizRequest, this.isShow = false});
  final QuizRequest quizRequest;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    final Widget item = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        QuizRequestItemMainContent(
          quizRequest: quizRequest,
        ),
        QuizRequestItemEditTargetButton(
          quizRequest: quizRequest,
        ),
        QuizRequestItemDestroyButton(quizRequest: quizRequest),
        QuizRequestItemCommentsButton(
          quizRequest: quizRequest,
        ),
        const SizedBox(
          height: 8,
        ),
        QuizRequestVoteButtons(
          quizRequest: quizRequest,
          quizRequestVote: quizRequest.quizRequestVote,
        ),
        QuizRequestItemDetailsButton(
          quizRequest: quizRequest,
          isShow: isShow,
        ),
        const Divider(
          thickness: 1,
        ),
      ],
    );
    if (quizRequest.closed()) {
      return item;
    }

    return QuizRequestPendingWrapper(item: item);
  }
}
