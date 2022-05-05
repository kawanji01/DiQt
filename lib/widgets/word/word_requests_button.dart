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
    Widget _acceptedWordRequestsButton() {
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

    Widget _pendingWordRequestsButton() {
      if (word.pendingWordRequestsCount == 0) return Container();

      final String redirectPath = 'words/${word.id}/pending_word_requests';
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
          '${word.pendingWordRequestsCount}件の審査中の編集',
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
