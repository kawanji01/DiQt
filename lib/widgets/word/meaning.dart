import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/markdown/markdown_without_dict_link.dart';
import 'package:flutter/material.dart';

class WordMeaning extends StatelessWidget {
  const WordMeaning({Key? key, required this.word}) : super(key: key);
  final Word? word;

  @override
  Widget build(BuildContext context) {
    if (word == null) return Container();

    return SizedBox(
      width: double.infinity,
      child: MarkdownWithoutDictLink(
        text: word!.meaning,
        textStyle: const TextStyle(
            fontSize: 18,
            height: 1.8,
            color: Colors.black54,
            fontWeight: FontWeight.bold),
        selectable: true,
      ),
    );
  }
}
