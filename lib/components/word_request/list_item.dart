import 'package:booqs_mobile/components/request_comment/list_button.dart';
import 'package:booqs_mobile/components/word_request/item/details_button.dart';
import 'package:booqs_mobile/components/word_request/item/main_content.dart';
import 'package:booqs_mobile/components/word_request/pending_wrapper.dart';
import 'package:booqs_mobile/components/word_request_vote/buttons.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';

class WordRequestListItem extends StatelessWidget {
  const WordRequestListItem({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    final Widget item = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        WordRequestItemMainContent(
          wordRequest: wordRequest,
        ),
        WordRequestItemDetailsButton(
          wordRequest: wordRequest,
        ),
        RequestCommentListButton(
          wordRequest: wordRequest,
        ),
        WordRequestVoteButtons(
          wordRequest: wordRequest,
          wordRequestVote: wordRequest.wordRequestVote,
        ),
        const Divider(
          thickness: 1,
        ),
      ],
    );
    if (wordRequest.closed()) {
      return item;
    }

    return WordRequestPendingWrapper(item: item);
  }
}
