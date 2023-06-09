import 'package:booqs_mobile/components/notice/timestamp.dart';
import 'package:booqs_mobile/components/user/feed_icon.dart';
import 'package:booqs_mobile/components/word_request/entry.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/notice.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';

class WordRequestAccepted extends StatelessWidget {
  const WordRequestAccepted({super.key, required this.notice});
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final WordRequest? wordRequest = notice.wordRequest;
    if (wordRequest == null) {
      return Container();
    }
    final User? user = wordRequest.user;
    if (user == null) {
      return Container();
    }

    final Widget message = Container(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      alignment: Alignment.centerLeft,
      child: Text(
        t.notices.word_request_accepted_message,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black87),
      ),
    );

    final Widget reference = Container(
        padding:
            const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black26)),
        child: Row(
          children: [
            UserFeedIcon(user: user),
            Expanded(
              child: WordRequestEntry(
                wordRequest: wordRequest,
              ),
            ),
          ],
        ));

    return Column(
      children: [
        NoticeTimestamp(notice: notice),
        message,
        reference,
        const SizedBox(height: 48),
      ],
    );
  }
}
