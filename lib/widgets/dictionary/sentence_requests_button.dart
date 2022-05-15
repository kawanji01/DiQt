import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/booqs_on_web.dart';
import 'package:booqs_mobile/widgets/button/small_green_button.dart';
import 'package:flutter/material.dart';

class DictionarySentenceRequestsButton extends StatelessWidget {
  const DictionarySentenceRequestsButton({Key? key, required this.dictionary})
      : super(key: key);
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    // 承認済の例文リクエスト
    Widget _acceptedSentenceRequestsButton() {
      final String btnText =
          '例文の改善履歴（${dictionary.acceptedSentenceRequestsCount}）';
      final String redirectPath =
          'dictionaries/${dictionary.publicUid}/accepted_sentence_requests';
      return InkWell(
        onTap: () {
          BooQsOnWeb.open(context, redirectPath);
        },
        child: SmallGreenButton(label: btnText, icon: Icons.history),
      );
    }

    // 審査中の例文リクエスト
    Widget _pendingSentenceRequestsButton() {
      final int requestsCount = dictionary.pendingSentenceRequestsCount;
      if (requestsCount == 0) return Container();
      final String btnText = '$requestsCount件の審査中の編集';
      final String redirectPath =
          'dictionaries/${dictionary.publicUid}/pending_sentence_requests';
      return TextButton(
          onPressed: () {
            BooQsOnWeb.open(context, redirectPath);
          },
          child: Text(
            btnText,
            style: const TextStyle(color: Colors.green, fontSize: 16),
          ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _acceptedSentenceRequestsButton(),
        _pendingSentenceRequestsButton()
      ],
    );
  }
}
