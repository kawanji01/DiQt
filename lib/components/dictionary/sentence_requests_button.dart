import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/sentence_request/dictionary.dart';
import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:flutter/material.dart';

class DictionarySentenceRequestsButton extends StatelessWidget {
  const DictionarySentenceRequestsButton({Key? key, required this.dictionary})
      : super(key: key);
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    // 審査中の例文リクエスト
    Widget pendingSentenceRequestsButton() {
      final int requestsCount = dictionary.pendingSentenceRequestsCount;
      if (requestsCount == 0) return Container();

      return TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 0),
          ),
          onPressed: () {
            SentenceRequestDictionaryPage.push(
                context, dictionary.id, 'pending');
          },
          child: Text(
            '${t.dictionaries.pending_sentence_requests}($requestsCount)',
            style: const TextStyle(color: Colors.green, fontSize: 16),
          ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            SentenceRequestDictionaryPage.push(
                context, dictionary.id, 'accepted');
          },
          child: SmallOutlineGrayButton(
              label:
                  '${t.dictionaries.accepted_sentence_requests}(${dictionary.acceptedSentenceRequestsCount})',
              icon: Icons.history),
        ),
        pendingSentenceRequestsButton()
      ],
    );
  }
}
