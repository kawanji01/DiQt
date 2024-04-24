import 'package:booqs_mobile/components/shared/timestamp.dart';
import 'package:booqs_mobile/components/word_request/item/dictionary.dart';
import 'package:booqs_mobile/components/word_request/item/diffs.dart';
import 'package:booqs_mobile/components/word_request/item/pending_reason.dart';
import 'package:booqs_mobile/components/word_request/item/user.dart';
import 'package:booqs_mobile/components/word_request/item/status.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';

class WordRequestItemMainContent extends StatelessWidget {
  const WordRequestItemMainContent({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedTimestamp(
          timestamp: wordRequest.createdAt,
        ),
        WordRequestItemUser(
          user: wordRequest.user,
        ),
        const SizedBox(
          height: 8,
        ),
        WordRequestItemDictionary(
          dictionary: wordRequest.dictionary!,
        ),
        WordRequestItemStatus(
          wordRequest: wordRequest,
        ),
        WordRequestItemPendingReason(
          wordRequest: wordRequest,
        ),
        const SizedBox(
          height: 24,
        ),
        WordRequestItemDiffs(
          wordRequest: wordRequest,
        ),
      ],
    );
  }
}
