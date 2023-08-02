import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/quiz_request/dictionary.dart';
import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:flutter/material.dart';

class DictionaryQuizRequestsButton extends StatelessWidget {
  const DictionaryQuizRequestsButton({Key? key, required this.dictionary})
      : super(key: key);
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    Widget pendingQuizRequestsButton() {
      int requestsCount = dictionary.pendingQuizRequestsCount;
      if (requestsCount == 0) return Container();

      return TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 0),
          ),
          onPressed: () {
            QuizRequestDictionaryPage.push(context, dictionary.id, 'pending');
          },
          child: Text(
            '${t.dictionaries.pending_quiz_requests}(${dictionary.pendingQuizRequestsCount})',
            style: const TextStyle(color: Colors.green, fontSize: 16),
          ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            QuizRequestDictionaryPage.push(context, dictionary.id, 'accepted');
          },
          child: SmallOutlineGrayButton(
              label:
                  '${t.dictionaries.accepted_quiz_requests}(${dictionary.acceptedQuizRequestsCount})',
              icon: Icons.history),
        ),
        pendingQuizRequestsButton()
      ],
    );
  }
}
