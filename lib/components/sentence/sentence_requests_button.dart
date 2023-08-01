import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/pages/sentence_request/sentence.dart';
import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:flutter/material.dart';

class SentenceSentenceRequestsButton extends StatelessWidget {
  const SentenceSentenceRequestsButton({Key? key, required this.sentence})
      : super(key: key);
  final Sentence sentence;

  @override
  Widget build(BuildContext context) {
    Widget pendingSentenceRequestsButton() {
      if (sentence.pendingSentenceRequestsCount == 0) return Container();
      return TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          textStyle: const TextStyle(fontSize: 16),
        ),
        onPressed: () {
          SentenceRequestSentencePage.push(context, sentence.id, 'pending');
        },
        child: Text(
          '${t.dictionaries.pending_sentence_requests}(${sentence.pendingSentenceRequestsCount})',
          style: const TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
            onTap: () {
              SentenceRequestSentencePage.push(
                  context, sentence.id, 'accepted');
            },
            child: SmallOutlineGrayButton(
              icon: Icons.history,
              label:
                  '${t.dictionaries.accepted_sentence_requests}（${sentence.acceptedSentenceRequestsCount}）',
            )),
        pendingSentenceRequestsButton()
      ],
    );
  }
}
