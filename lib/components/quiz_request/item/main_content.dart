import 'package:booqs_mobile/components/quiz_request/item/diffs.dart';
import 'package:booqs_mobile/components/quiz_request/item/drill.dart';
import 'package:booqs_mobile/components/quiz_request/item/pending_reason.dart';
import 'package:booqs_mobile/components/quiz_request/item/status.dart';
import 'package:booqs_mobile/components/shared/timestamp.dart';
import 'package:booqs_mobile/components/word_request/item/user.dart';
import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:flutter/material.dart';

class QuizRequestItemMainContent extends StatelessWidget {
  const QuizRequestItemMainContent({super.key, required this.quizRequest});
  final QuizRequest quizRequest;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedTimestamp(
          timestamp: quizRequest.createdAt,
        ),
        WordRequestItemUser(
          user: quizRequest.user,
        ),
        const SizedBox(
          height: 8,
        ),
        QuizRequestItemDrill(
          quizRequest: quizRequest,
        ),
        QuizRequestItemStatus(
          quizRequest: quizRequest,
        ),
        QuizRequestItemPendingReason(
          quizRequest: quizRequest,
        ),
        const SizedBox(
          height: 24,
        ),
        QuizRequestItemDiffs(
          quizRequest: quizRequest,
        ),
      ],
    );
  }
}
