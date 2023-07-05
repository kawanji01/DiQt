import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/word_request/dictionary.dart';
import 'package:booqs_mobile/components/button/small_outline_gray_button.dart';
import 'package:booqs_mobile/utils/diqt_browser_dialog.dart';
import 'package:flutter/material.dart';

class DictionaryWordRequestsButton extends StatelessWidget {
  const DictionaryWordRequestsButton({Key? key, required this.dictionary})
      : super(key: key);
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    // 承認済の辞書リクエスト
    Widget acceptedWordRequestsButton() {
      // final String btnText =
      //    ;
      final String redirectPath =
          'dictionaries/${dictionary.id}/accepted_word_requests';
      return InkWell(
        onTap: () {
          // WordRequestDictionaryPage.push(context, dictionary.id, 'accepted');
          DiQtBrowserDialog.open(context, redirectPath);
        },
        child: SmallOutlineGrayButton(
            label:
                '${t.dictionaries.accepted_word_requests}（${dictionary.acceptedWordRequestsCount}）',
            icon: Icons.history),
      );
    }

    // 保留中の辞書リクエスト
    Widget pendingWordRequestsButton() {
      final int pendingRequestsCount = dictionary.pendingWordRequestsCount;
      if (pendingRequestsCount == 0) return Container();
      final String btnText =
          '${t.dictionaries.pending_word_requests}($pendingRequestsCount)';
      final String redirectPath =
          'dictionaries/${dictionary.id}/pending_word_requests';
      return TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 0),
          ),
          onPressed: () {
            //WordRequestDictionaryPage.push(context, dictionary.id, 'pending');
            DiQtBrowserDialog.open(context, redirectPath);
          },
          child: Text(
            btnText,
            style: const TextStyle(color: Colors.green, fontSize: 16),
          ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [acceptedWordRequestsButton(), pendingWordRequestsButton()],
    );
  }
}
