import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/shared/text_with_link.dart';
import 'package:flutter/material.dart';

class WordFormPreviewScreen extends StatelessWidget {
  const WordFormPreviewScreen(
      {Key? key,
      required this.entry,
      required this.meaning,
      required this.explanation,
      required this.dictionary})
      : super(key: key);
  final String entry;
  final String meaning;
  final String explanation;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    const heading = Text('項目のプレビュー',
        style: TextStyle(
            fontSize: 24, color: Colors.black87, fontWeight: FontWeight.bold));

    return Container(
      height: 560,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          heading,
          const SizedBox(
            height: 16,
          ),
          const SharedItemLabel(text: '項目'),
          const SizedBox(
            height: 16,
          ),
          Text(entry,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 32,
          ),
          const SharedItemLabel(text: '意味'),
          const SizedBox(
            height: 16,
          ),
          Text(meaning,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 32,
          ),
          const SharedItemLabel(text: '解説'),
          TextWithLink(
            text: explanation,
            autoLinkEnabled: false,
            crossAxisAlignment: CrossAxisAlignment.start,
            dictionaryId: dictionary.id,
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      )),
    );
  }
}
