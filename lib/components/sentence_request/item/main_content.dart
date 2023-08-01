import 'package:booqs_mobile/components/sentence_request/item/pending_reason.dart';
import 'package:booqs_mobile/components/sentence_request/item/status.dart';
import 'package:booqs_mobile/components/shared/timestamp.dart';
import 'package:booqs_mobile/components/sentence_request/item/diffs.dart';
import 'package:booqs_mobile/components/word_request/item/dictionary.dart';
import 'package:booqs_mobile/components/word_request/item/user.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:flutter/material.dart';

class SentenceRequestItemMainContent extends StatelessWidget {
  const SentenceRequestItemMainContent(
      {super.key, required this.sentenceRequest});
  final SentenceRequest sentenceRequest;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedTimestamp(
          timestamp: sentenceRequest.createdAt,
        ),
        WordRequestItemUser(
          user: sentenceRequest.user,
        ),
        const SizedBox(
          height: 8,
        ),
        WordRequestItemDictionary(
          dictionary: sentenceRequest.dictionary!,
        ),
        SentenceRequestItemStatus(
          sentenceRequest: sentenceRequest,
        ),
        SentenceRequestItemPendingReason(
          sentenceRequest: sentenceRequest,
        ),
        const SizedBox(
          height: 24,
        ),
        SentenceRequestItemDiffs(
          sentenceRequest: sentenceRequest,
        ),
      ],
    );
  }
}
