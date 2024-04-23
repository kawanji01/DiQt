import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:booqs_mobile/pages/word_request/show.dart';
import 'package:flutter/material.dart';

class WordRequestItemDetailsButton extends StatelessWidget {
  const WordRequestItemDetailsButton(
      {super.key, required this.wordRequest, this.isShow = false});
  final WordRequest wordRequest;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    if (isShow) {
      return Container();
    }
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          WordRequestShowPage.push(context, wordRequest.id);
        },
        child: Text(
          t.shared.details,
          style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
