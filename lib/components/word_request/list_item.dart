import 'package:booqs_mobile/components/word_request/accepted_item.dart';
import 'package:booqs_mobile/components/word_request/pending_item.dart';
import 'package:booqs_mobile/components/word_request/rejected_item.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/widgets.dart';

class WordRequestListItem extends StatelessWidget {
  const WordRequestListItem({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    if (wordRequest.isPending()) {
      return WordRequestPendingItem(wordRequest: wordRequest);
    } else if (wordRequest.acceptance) {
      return WordRequestAcceptedItem(wordRequest: wordRequest);
    } else {
      return WordRequestRejectedItem(wordRequest: wordRequest);
    }
  }
}
