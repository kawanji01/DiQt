import 'package:booqs_mobile/components/sentence_request/item/comments_button.dart';
import 'package:booqs_mobile/components/sentence_request/item/destroy_button.dart';
import 'package:booqs_mobile/components/sentence_request/item/details_button.dart';
import 'package:booqs_mobile/components/sentence_request/item/edit_target_button.dart';
import 'package:booqs_mobile/components/sentence_request/item/main_content.dart';
import 'package:booqs_mobile/components/sentence_request/pending_wrapper.dart';
import 'package:booqs_mobile/components/sentence_request_vote/buttons.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:flutter/material.dart';

class SentenceRequestListItem extends StatelessWidget {
  const SentenceRequestListItem(
      {super.key, required this.sentenceRequest, this.isShow = false});
  final SentenceRequest sentenceRequest;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    final Widget item = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        SentenceRequestItemMainContent(
          sentenceRequest: sentenceRequest,
        ),
        SentenceRequestItemEditTargetButton(
          sentenceRequest: sentenceRequest,
        ),
        SentenceRequestItemDestroyButton(sentenceRequest: sentenceRequest),
        SentenceRequestItemCommentsButton(
          sentenceRequest: sentenceRequest,
        ),
        const SizedBox(
          height: 8,
        ),
        SentenceRequestVoteButtons(
          sentenceRequest: sentenceRequest,
          sentenceRequestVote: sentenceRequest.sentenceRequestVote,
        ),
        SentenceRequestItemDetailsButton(
          sentenceRequest: sentenceRequest,
          isShow: isShow,
        ),
        const Divider(
          thickness: 1,
        ),
      ],
    );
    if (sentenceRequest.closed()) {
      return item;
    }

    return SentenceRequestPendingWrapper(item: item);
  }
}
