import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/utils/diqt_browser_dialog.dart';
import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:flutter/material.dart';

class SentenceSentenceRequestsButton extends StatelessWidget {
  const SentenceSentenceRequestsButton({Key? key, required this.sentence})
      : super(key: key);
  final Sentence sentence;

  @override
  Widget build(BuildContext context) {
    Widget acceptedSentenceRequestsButton() {
      final String redirectPath =
          'sentences/${sentence.id}/accepted_sentence_requests';
      return InkWell(
          onTap: () {
            DiQtBrowserDialog.open(context, redirectPath);
          },
          child: SmallOutlineGrayButton(
            icon: Icons.history,
            label: '例文の改善履歴（${sentence.acceptedSentenceRequestsCount}）',
          ));
    }

    Widget pendingSentenceRequestsButton() {
      if (sentence.pendingSentenceRequestsCount == 0) return Container();

      final String redirectPath =
          'sentences/${sentence.id}/pending_sentence_requests';
      return TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          textStyle: const TextStyle(fontSize: 16),
        ),
        onPressed: () {
          DiQtBrowserDialog.open(context, redirectPath);
        },
        child: Text(
          '${sentence.pendingSentenceRequestsCount}件の審査中の編集',
          style: const TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        acceptedSentenceRequestsButton(),
        pendingSentenceRequestsButton()
      ],
    );
  }
}
