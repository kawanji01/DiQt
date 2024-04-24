import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class SentenceFormAIModel extends StatefulWidget {
  const SentenceFormAIModel({super.key, required this.aiModelController});
  final TextEditingController aiModelController;

  @override
  State<SentenceFormAIModel> createState() => _SentenceFormAIModelState();
}

class _SentenceFormAIModelState extends State<SentenceFormAIModel> {
  @override
  Widget build(BuildContext context) {
    String dropDownValue = widget.aiModelController.text;
    if ([
          '3',
          '4',
        ].contains(dropDownValue) ==
        false) {
      dropDownValue = '3';
    }

    List<DropdownMenuItem<String>> dropDownItems = [
      // 未定義
      DropdownMenuItem<String>(
        value: '0',
        child: Text(t.shared.undefined,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black87)),
      ),
      // GPT-3.5
      DropdownMenuItem<String>(
        value: '3',
        child: Text(t.sentences.gpt_3_5,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black87)),
      ),
      // GPT-4
      DropdownMenuItem<String>(
        value: '4',
        child: Text(t.sentences.gpt_4,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black87)),
      ),
    ];

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SharedItemLabel(
        text: t.sentences.model,
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
              widget.aiModelController.text = '$newValue';
            });
          },
          items: dropDownItems,
        ),
      ),
    ]);
  }
}
