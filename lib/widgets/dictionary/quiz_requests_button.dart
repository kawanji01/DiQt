import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/booqs_on_web.dart';
import 'package:booqs_mobile/widgets/button/small_green_button.dart';
import 'package:flutter/material.dart';

class DictionaryQuizRequestsButton extends StatelessWidget {
  const DictionaryQuizRequestsButton({Key? key, required this.dictionary})
      : super(key: key);
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    Widget _acceptedQuizRequestsButton() {
      final String btnText = '問題の改善履歴（${dictionary.acceptedQuizRequestsCount}）';
      final String redirectPath =
          'dictionaries/${dictionary.publicUid}/accepted_quiz_requests';
      return InkWell(
        onTap: () {
          BooQsOnWeb.open(context, redirectPath);
        },
        child: SmallGreenButton(label: btnText, icon: Icons.history),
      );
    }

    Widget _pendingQuizRequestsButton() {
      int requestsCount = dictionary.pendingQuizRequestsCount;
      if (requestsCount == 0) return Container();

      final String btnText = '$requestsCount件の審査中の編集';
      final String redirectPath =
          'dictionaries/${dictionary.publicUid}/pending_quiz_requests';
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
      children: [_acceptedQuizRequestsButton(), _pendingQuizRequestsButton()],
    );
  }
}
