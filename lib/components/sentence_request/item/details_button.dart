import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence_request.dart';
import 'package:booqs_mobile/pages/sentence_request/show.dart';
import 'package:flutter/material.dart';

class SentenceRequestItemDetailsButton extends StatelessWidget {
  const SentenceRequestItemDetailsButton(
      {super.key, required this.sentenceRequest, this.isShow = false});
  final SentenceRequest sentenceRequest;
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
          SentenceRequestShowPage.push(context, sentenceRequest.id);
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
