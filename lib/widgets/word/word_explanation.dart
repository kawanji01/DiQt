import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/sentence/sentence_reminder_button.dart';
import 'package:booqs_mobile/widgets/shared/text_with_link.dart';
import 'package:booqs_mobile/widgets/word/word_edit_button.dart';
import 'package:flutter/material.dart';

class WordExplanation extends StatelessWidget {
  const WordExplanation({Key? key, required this.word}) : super(key: key);
  final Word? word;

  @override
  Widget build(BuildContext context) {
    if (word == null) return Container();

    Widget _heading(text) {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black87),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(text,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)));
    }

    Widget _pronunciationPart() {
      if (word!.ipa == null || word!.ipa == '') return Container();

      return Row(
        children: <Widget>[
          _heading('発音記号（IPA）'),
          const SizedBox(
            width: 12,
          ),
          Text('${word!.ipa}', style: const TextStyle(fontSize: 16)),
        ],
      );
    }

    Widget _explanation() {
      if (word!.explanation == '') return Container();

      final expText = word!.explanation;
      return Column(
          // 左寄せ
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _heading('解説'),
            const SizedBox(height: 8),
            TextWithLink(text: expText, autoLinkEnabled: false),
          ]);
    }

    Widget _sentence() {
      final String original = word!.originalOfSentence ?? '';
      final String translation = word!.translationOfSentence ?? '';

      if (original == '') return Container();

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _heading('例文'),
        const SizedBox(height: 8),
        TextWithLink(text: original, autoLinkEnabled: true),
        const SizedBox(height: 8),
        Text(translation,
            style: const TextStyle(
                fontSize: 16, height: 1.6, color: Colors.black87)),
        const SizedBox(height: 24),
        SentenceReminderButton(sentenceId: word!.sentenceId!)
      ]);
    }

    return Column(
      children: <Widget>[
        const SizedBox(height: 24),
        _pronunciationPart(),
        const SizedBox(height: 24),
        _explanation(),
        const SizedBox(height: 24),
        _sentence(),
        const SizedBox(height: 24),
        WordEditButton(word: word),
      ],
    );
  }
}
