import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:flutter/material.dart';

class SentenceRequestItemPendingReason extends StatelessWidget {
  const SentenceRequestItemPendingReason(
      {super.key, required this.sentenceRequest});
  final SentenceRequest sentenceRequest;

  @override
  Widget build(BuildContext context) {
    //if (sentenceRequest.closed()) {
    return Container();
    //}

    /* List<Widget> pendingReasons() {
      final List<String> reasonList =
          sentenceRequest.pendingReason?.split(',') ?? [''];
      return reasonList.map((String reason) {
        String reasonText;
        switch (reason) {
          case 'duplicating_entry':
            reasonText = t.wordRequests.duplicating_entry;
            break;
          case 'changing_entry':
            reasonText = t.wordRequests.changing_entry;
            break;
          case 'pending_elimination':
            reasonText = t.wordRequests.pending_elimination;
            break;
          case 'pending_modification':
            reasonText = t.wordRequests.pending_modification;
            break;
          case 'pending_addition':
            reasonText = t.wordRequests.pending_addition;
            break;
          default:
            reasonText = t.wordRequests.unknown_reason;
            break;
        }
        return Text(
          '・$reasonText',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Color(0xFF721c24),
          ),
        );
      }).toList();
    }

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 24),
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFf8d7da),
          border: Border.all(color: const Color(0xFFf5c6cb)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            '${t.wordRequests.pending_reason}:',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF721c24),
            ),
          ),
          ...pendingReasons(),
        ])); */
  }
}
