import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/utils/booqs_on_web.dart';
import 'package:booqs_mobile/widgets/button/small_outline_gray_button.dart';
import 'package:flutter/material.dart';

class WordWordRequestsButton extends StatelessWidget {
  const WordWordRequestsButton({Key? key, required this.word})
      : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    Widget acceptedWordRequestsButton() {
      final String redirectPath = 'words/${word.id}/accepted_word_requests';
      return InkWell(
          onTap: () {
            BooQsOnWeb.open(context, redirectPath);
          },
          child: SmallOutlineGrayButton(
            icon: Icons.history,
            label: '項目の改善履歴（${word.acceptedWordRequestsCount}）',
          ));
    }

    Widget pendingWordRequestsButton() {
      if (word.pendingWordRequestsCount == 0) return Container();

      final String redirectPath = 'words/${word.id}/pending_word_requests';
      return TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          textStyle: const TextStyle(fontSize: 16),
        ),
        onPressed: () {
          BooQsOnWeb.open(context, redirectPath);
        },
        child: Text(
          '${word.pendingWordRequestsCount}件の審査中の編集',
          style: const TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [acceptedWordRequestsButton(), pendingWordRequestsButton()],
    );
  }
}
