import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/material.dart';

class WordRequestVoteUpvoteButton extends StatelessWidget {
  const WordRequestVoteUpvoteButton(
      {super.key, required this.wordRequest, required this.upvoted});
  final WordRequest wordRequest;
  final bool? upvoted;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color(0xFF2ecc71);
    Color textColor = Colors.white;

    if (upvoted == null || upvoted == false) {
      backgroundColor = const Color(
        0xFFeffaf5,
      );
      textColor = const Color.fromRGBO(37, 121, 83, 1);
    }
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Row(
          children: [
            Icon(
              Icons.thumb_up,
              size: 18,
              color: textColor,
            ),
            const SizedBox(width: 4),
            Text(t.wordRequests.upvote,
                style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.bold)),
            const SizedBox(width: 4),
            Text(wordRequest.upvotesCount.toString(),
                style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                    fontWeight: FontWeight.normal)),
          ],
        ));
  }
}
