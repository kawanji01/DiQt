import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/markdown/markdown_without_dict_link.dart';
import 'package:flutter/material.dart';

class WordItemMeaning extends StatelessWidget {
  const WordItemMeaning({Key? key, required this.word}) : super(key: key);
  final Word? word;

  @override
  Widget build(BuildContext context) {
    if (word == null) return Container();

    return SizedBox(
      width: double.infinity,
      child: Text(
        word!.meaning,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
