import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/pages/sentence_request/sentence.dart';
import 'package:flutter/material.dart';

class SentenceRequestSentenceTabs extends StatelessWidget {
  const SentenceRequestSentenceTabs(
      {super.key, required this.selected, required this.sentence});
  final String selected;
  final Sentence sentence;

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
                '${t.wordRequests.acceptance}\n(${sentence.acceptedSentenceRequestsCount})',
            style: style),
      );
      return InkWell(
        onTap: () {
          SentenceRequestSentencePage.pushReplacement(
              context, sentence.id, 'accepted');
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
                '${t.wordRequests.pending}\n(${sentence.pendingSentenceRequestsCount})',
            style: style),
      );
      return InkWell(
        onTap: () {
          SentenceRequestSentencePage.pushReplacement(
              context, sentence.id, 'pending');
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
                '${t.wordRequests.rejection}\n(${sentence.rejectedSentenceRequestsCount()})',
            style: style),
      );
      return InkWell(
        onTap: () {
          SentenceRequestSentencePage.pushReplacement(
              context, sentence.id, 'rejected');
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
