import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/booqs_on_web.dart';
import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:flutter/material.dart';

class DictionarySentenceRequestsButton extends StatelessWidget {
  const DictionarySentenceRequestsButton({Key? key, required this.dictionary})
      : super(key: key);
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    // 承認済の例文リクエスト
    Widget acceptedSentenceRequestsButton() {
      final String btnText =
          '例文の改善履歴（${dictionary.acceptedSentenceRequestsCount}）';
      final String redirectPath =
          'dictionaries/${dictionary.id}/accepted_sentence_requests';
      return InkWell(
        onTap: () {
          BooQsOnWeb.open(context, redirectPath);
        },
        child: SmallOutlineGrayButton(label: btnText, icon: Icons.history),
      );
    }

    // 審査中の例文リクエスト
    Widget pendingSentenceRequestsButton() {
      final int requestsCount = dictionary.pendingSentenceRequestsCount;
      if (requestsCount == 0) return Container();
      final String btnText = '$requestsCount件の審査中の編集';
      final String redirectPath =
          'dictionaries/${dictionary.id}/pending_sentence_requests';
      return TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 0),
          ),
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
        acceptedSentenceRequestsButton(),
        pendingSentenceRequestsButton()
      ],
    );
  }
}
