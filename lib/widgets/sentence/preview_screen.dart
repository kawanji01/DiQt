import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/shared/text_with_link.dart';
import 'package:flutter/material.dart';

class SentencePreviewScreen extends StatelessWidget {
  const SentencePreviewScreen(
      {Key? key,
      required this.original,
      required this.translation,
      required this.explanation})
      : super(key: key);
  final String original;
  final String translation;
  final String explanation;

  @override
  Widget build(BuildContext context) {
    const heading = Text('例文のプレビュー',
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
          const SharedItemLabel(text: '例文'),
          const SizedBox(
            height: 16,
          ),
          TextWithLink(
            text: original,
            autoLinkEnabled: true,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          const SizedBox(
            height: 32,
          ),
          const SharedItemLabel(text: '訳'),
          const SizedBox(
            height: 16,
          ),
          Text(translation,
              style: const TextStyle(fontSize: 16, color: Colors.black87)),
          const SizedBox(
            height: 32,
          ),
          const SharedItemLabel(text: '解説'),
          TextWithLink(
            text: explanation,
            autoLinkEnabled: false,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      )),
    );
  }
}
