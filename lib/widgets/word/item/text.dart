import 'package:booqs_mobile/consts/language.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/shared/text_with_dict_link.dart';
import 'package:flutter/material.dart';

class WordItemText extends StatelessWidget {
  const WordItemText({Key? key, required this.word, required this.text})
      : super(key: key);
  final Word word;
  final String text;

  @override
  Widget build(BuildContext context) {
    if (word.langNumberOfEntry == word.langNumberOfMeaning &&
        word.langNumberOfMeaning == languageCodeMap['en']) {
      return TextWithDictLink(
        text: text,
        langNumber: word.langNumberOfMeaning,
        autoLinkEnabled: true,
        crossAxisAlignment: CrossAxisAlignment.start,
        dictionaryId: word.dictionaryId,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontColor: Colors.black87,
        selectable: true,
      );
    }
    return Text(text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.normal,
        ));
  }
}
