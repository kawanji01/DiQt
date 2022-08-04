import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/markdown/markdown_with_dict_link.dart';
import 'package:booqs_mobile/widgets/word/label.dart';
import 'package:flutter/material.dart';

class WordExplanation extends StatelessWidget {
  const WordExplanation({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    Widget _pronunciationPart() {
      if (word.ipa == null || word.ipa == '') return Container();

      return Column(
        children: [
          const SizedBox(height: 24),
          Row(
            children: <Widget>[
              const SizedBox(height: 24),
              const WordLabel(text: '発音記号（IPA）'),
              const SizedBox(
                width: 12,
              ),
              Text('${word.ipa}', style: const TextStyle(fontSize: 16)),
            ],
          ),
        ],
      );
    }

    Widget _explanation() {
      if (word.explanation == '') return Container();

      return Column(
          // 左寄せ
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const WordLabel(text: '解説'),
            const SizedBox(height: 8),
            MarkdownWithDictLink(
              text: word.explanation ?? '',
              dictionaryId: word.dictionaryId,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontColor: Colors.black87,
              selectable: true,
            ),
          ]);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _pronunciationPart(),
        _explanation(),
      ],
    );
  }
}
