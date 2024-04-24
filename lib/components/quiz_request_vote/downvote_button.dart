import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/quiz_request.dart';
import 'package:flutter/material.dart';

class QuizRequestVoteDownvoteButton extends StatelessWidget {
  const QuizRequestVoteDownvoteButton(
      {super.key, required this.quizRequest, required this.upvoted});
  final QuizRequest quizRequest;
  final bool? upvoted;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color(0xFFEE5A5A);
    Color textColor = Colors.white;
    if (upvoted == null || upvoted == true) {
      backgroundColor = const Color(
        0xFFf5f5f5,
      );
      textColor = const Color.fromRGBO(0, 0, 0, 0.7);
    }
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Row(
          children: [
            //const FaIcon(
            //  FontAwesomeIcons.thumbsDown,
            //  size: 18,
            //  color: Color.fromRGBO(0, 0, 0, 0.7),
            //),
            Icon(
              Icons.thumb_down,
              size: 18,
              color: textColor,
            ),
            const SizedBox(width: 4),
            Text(t.wordRequests.downvote,
                style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.bold)),
            const SizedBox(width: 4),
            Text(quizRequest.downvotesCount.toString(),
                style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                    fontWeight: FontWeight.normal)),
          ],
        ));
  }
}
