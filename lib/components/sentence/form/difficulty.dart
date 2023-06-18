import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class SentenceFormDifficulty extends StatefulWidget {
  const SentenceFormDifficulty({super.key, required this.difficultyController});
  final TextEditingController difficultyController;

  @override
  State<SentenceFormDifficulty> createState() => _SentenceFormDifficultyState();
}

class _SentenceFormDifficultyState extends State<SentenceFormDifficulty> {
  @override
  Widget build(BuildContext context) {
    String dropDownValue = widget.difficultyController.text;
    if ([
          '',
          'Easy',
          'Normal',
          'Difficult',
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
      // easy
      DropdownMenuItem<String>(
        value: 'Easy',
        child: Text(t.sentences.easy,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black87)),
      ),
      // normal
      DropdownMenuItem<String>(
        value: 'Normal',
        child: Text(t.sentences.normal,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black87)),
      ),
      // difficult
      DropdownMenuItem<String>(
        value: 'Difficult',
        child: Text(t.sentences.difficult,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black87)),
      ),
    ];

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SharedItemLabel(
        text: t.sentences.difficulty,
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
              widget.difficultyController.text = '$newValue';
            });
          },
          items: dropDownItems,
        ),
      ),
    ]);
  }
}
