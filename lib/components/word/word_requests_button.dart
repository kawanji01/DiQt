import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/word_request/word.dart';
import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:flutter/material.dart';

class WordWordRequestsButton extends StatelessWidget {
  const WordWordRequestsButton({super.key, required this.word});
  final Word word;

  @override
  Widget build(BuildContext context) {
    Widget acceptedWordRequestsButton() {
      return InkWell(
          onTap: () {
            WordRequestWordPage.push(context, word.id, 'accepted');
          },
          child: SmallOutlineGrayButton(
            icon: Icons.history,
            label:
                '${t.wordRequests.edit_histories}（${word.acceptedWordRequestsCount}）',
          ));
    }

    Widget pendingWordRequestsButton() {
      if (word.pendingWordRequestsCount == 0) return Container();

      return TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          textStyle: const TextStyle(fontSize: 16),
        ),
        onPressed: () {
          WordRequestWordPage.push(context, word.id, 'pending');
        },
        child: Text(
          '${t.wordRequests.pending_edits}(${word.pendingWordRequestsCount})',
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
