import 'package:booqs_mobile/components/sentence_request/list_item.dart';
import 'package:booqs_mobile/components/shared/timestamp.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/notice.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:flutter/material.dart';

class NoticeSentenceRequestAccepted extends StatelessWidget {
  const NoticeSentenceRequestAccepted({super.key, required this.notice});
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final SentenceRequest? sentenceRequest = notice.sentenceRequest;
    if (sentenceRequest == null) {
      return Text(
          t.shared.no_items_found(name: t.sentenceRequests.sentence_requests));
    }
    final User? user = sentenceRequest.user;
    if (user == null) {
      return Text(t.shared.no_items_found(name: t.users.user));
    }

    return Column(
      children: [
        SharedTimestamp(timestamp: notice.createdAt),
        // message
        Container(
          padding: const EdgeInsets.only(top: 16, bottom: 24),
          alignment: Alignment.centerLeft,
          child: Text(
            t.notices.sentence_request_accepted_message,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
        ),
        Container(
          padding:
              const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.black26)),
          child: SentenceRequestListItem(
            sentenceRequest: sentenceRequest,
          ),
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}
