import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/utils/booqs_on_web.dart';
import 'package:booqs_mobile/widgets/button/small_outline_gray_button.dart';
import 'package:flutter/material.dart';

class SentenceSentenceRequestsButton extends StatelessWidget {
  const SentenceSentenceRequestsButton({Key? key, required this.sentence})
      : super(key: key);
  final Sentence sentence;

  @override
  Widget build(BuildContext context) {
    Widget _acceptedWordRequestsButton() {
      final String redirectPath =
          'sentences/${sentence.id}/accepted_sentence_requests';
      return InkWell(
          onTap: () {
            BooQsOnWeb.open(context, redirectPath);
          },
          child: SmallOutlineGrayButton(
            icon: Icons.history,
            label: '例文の改善履歴（${sentence.acceptedSentenceRequestsCount}）',
          ));
    }

    Widget _pendingWordRequestsButton() {
      if (sentence.pendingSentenceRequestsCount == 0) return Container();

      final String redirectPath =
          'sentences/${sentence.id}/pending_sentence_requests';
      return TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          primary: Colors.green,
          textStyle: const TextStyle(fontSize: 10),
        ),
        onPressed: () {
          BooQsOnWeb.open(context, redirectPath);
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
      children: [_acceptedWordRequestsButton(), _pendingWordRequestsButton()],
    );
  }
}
