import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/booqs_on_web.dart';
import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:flutter/material.dart';

class DictionaryQuizRequestsButton extends StatelessWidget {
  const DictionaryQuizRequestsButton({Key? key, required this.dictionary})
      : super(key: key);
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    Widget acceptedQuizRequestsButton() {
      final String btnText = '問題の改善履歴（${dictionary.acceptedQuizRequestsCount}）';
      final String redirectPath =
          'dictionaries/${dictionary.id}/accepted_quiz_requests';
      return InkWell(
        onTap: () {
          BooQsOnWeb.open(context, redirectPath);
        },
        child: SmallOutlineGrayButton(label: btnText, icon: Icons.history),
      );
    }

    Widget pendingQuizRequestsButton() {
      int requestsCount = dictionary.pendingQuizRequestsCount;
      if (requestsCount == 0) return Container();

      final String btnText = '$requestsCount件の審査中の編集';
      final String redirectPath =
          'dictionaries/${dictionary.id}/pending_quiz_requests';
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
      children: [acceptedQuizRequestsButton(), pendingQuizRequestsButton()],
    );
  }
}
