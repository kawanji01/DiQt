import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/word_request/dictionary.dart';
import 'package:flutter/material.dart';

class WordRequestDictionaryTabs extends StatelessWidget {
  const WordRequestDictionaryTabs(
      {super.key, required this.selected, required this.dictionary});
  final String selected;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    const selectedStyle = TextStyle(
        color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold);
    const normalStyle = TextStyle(
        color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold);

    Widget accepted() {
      final style = selected == 'accepted' ? selectedStyle : normalStyle;
      final text = RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text:
                '${t.wordRequests.acceptance}\n(${dictionary.acceptedWordRequestsCount})',
            style: style),
      );
      return InkWell(
        onTap: () {
          WordRequestDictionaryPage.pushReplacement(
              context, dictionary.id, 'accepted');
        },
        child: Container(alignment: Alignment.center, child: text),
      );
    }

    Widget pending() {
      final style = selected == 'pending' ? selectedStyle : normalStyle;
      final text = RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text:
                '${t.wordRequests.pending}\n(${dictionary.pendingWordRequestsCount})',
            style: style),
      );
      return InkWell(
        onTap: () {
          WordRequestDictionaryPage.pushReplacement(
              context, dictionary.id, 'pending');
        },
        child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(width: 0.5, color: Colors.black54),
                right: BorderSide(width: 0.5, color: Colors.black54),
              ),
            ),
            child: text),
      );
    }

    Widget rejected() {
      final style = selected == 'rejected' ? selectedStyle : normalStyle;
      final text = RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text:
                '${t.wordRequests.rejection}\n(${dictionary.rejectedWordRequestsCount()})',
            style: style),
      );
      return InkWell(
        onTap: () {
          WordRequestDictionaryPage.pushReplacement(
              context, dictionary.id, 'rejected');
        },
        child: Container(alignment: Alignment.center, child: text),
      );
    }

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: accepted(),
        ),
        Expanded(flex: 1, child: pending()),
        Expanded(flex: 1, child: rejected()),
      ],
    );
  }
}
