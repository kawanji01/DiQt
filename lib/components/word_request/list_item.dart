import 'package:booqs_mobile/components/word_request/item/comments_button.dart';
import 'package:booqs_mobile/components/word_request/item/details_button.dart';
import 'package:booqs_mobile/components/word_request/item/edit_target_button.dart';
import 'package:booqs_mobile/components/word_request/item/main_content.dart';
import 'package:booqs_mobile/components/word_request/pending_wrapper.dart';
import 'package:booqs_mobile/components/word_request_vote/buttons.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';

class WordRequestListItem extends StatelessWidget {
  const WordRequestListItem(
      {super.key, required this.wordRequest, this.isShow = false});
  final WordRequest wordRequest;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    final Widget item = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        WordRequestItemMainContent(
          wordRequest: wordRequest,
        ),
        WordRequestItemEditTargetButton(
          wordRequest: wordRequest,
        ),
        WordRequestItemCommentsButton(
          wordRequest: wordRequest,
        ),
        const SizedBox(
          height: 8,
        ),
        WordRequestVoteButtons(
          wordRequest: wordRequest,
          wordRequestVote: wordRequest.wordRequestVote,
        ),
        WordRequestItemDetailsButton(
          wordRequest: wordRequest,
          isShow: isShow,
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
