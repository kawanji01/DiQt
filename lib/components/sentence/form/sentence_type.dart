import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class SentenceFormSentenceType extends StatefulWidget {
  const SentenceFormSentenceType(
      {super.key, required this.sentenceTypeController});
  final TextEditingController sentenceTypeController;

  @override
  State<SentenceFormSentenceType> createState() =>
      _SentenceFormSentenceTypeState();
}

class _SentenceFormSentenceTypeState extends State<SentenceFormSentenceType> {
  @override
  Widget build(BuildContext context) {
    String dropDownValue = widget.sentenceTypeController.text;
    if ([
          '',
          'Declarative sentence',
          'Interrogative sentence',
          'Imperative sentence',
          'Exclamatory sentence'
        ].contains(dropDownValue) ==
        false) {
      dropDownValue = '';
    }

    List<DropdownMenuItem<String>> dropDownItems = [
      // 未定義
      DropdownMenuItem<String>(
        value: '',
        child: Text(t.shared.undefined,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black87)),
      ),
      // 平叙文
      DropdownMenuItem<String>(
        value: 'Declarative sentence',
        child: Text(t.sentences.declarative_sentence,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black87)),
      ),
      // 疑問文
      DropdownMenuItem<String>(
        value: 'Interrogative sentence',
        child: Text(t.sentences.interrogative_sentence,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black87)),
      ),
      // 命令文
      DropdownMenuItem<String>(
        value: 'Imperative sentence',
        child: Text(t.sentences.imperative_sentence,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black87)),
      ),
      // 感嘆文
      DropdownMenuItem<String>(
        value: 'Exclamatory sentence',
        child: Text(t.sentences.exclamatory_sentence,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black87)),
      ),
    ];

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SharedItemLabel(
        text: t.sentences.sentence_type,
      ),
      const SizedBox(height: 16),
      Container(
        height: 48,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 15.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black54)),
        child: DropdownButton<String>(
          value: dropDownValue,
          iconSize: 24,
          elevation: 16,
          onChanged: (String? newValue) {
            setState(() {
              widget.sentenceTypeController.text = '$newValue';
            });
          },
          items: dropDownItems,
        ),
      ),
    ]);
  }
}
