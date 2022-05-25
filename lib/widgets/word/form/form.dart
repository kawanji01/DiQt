import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/widgets/word/form/preview_button.dart';
import 'package:flutter/material.dart';

class WordForm extends StatefulWidget {
  const WordForm({
    Key? key,
    required this.entryController,
    required this.meaningController,
    required this.explanationController,
    required this.dictionary,
  }) : super(key: key);

  final TextEditingController entryController;
  final TextEditingController meaningController;
  final TextEditingController explanationController;
  final Dictionary dictionary;

  @override
  _WordFormState createState() => _WordFormState();
}

class _WordFormState extends State<WordForm> {
  TextEditingController? _entryController;
  TextEditingController? _meaningController;
  TextEditingController? _explanationController;

  @override
  void initState() {
    super.initState();
    _entryController = widget.entryController;
    _meaningController = widget.meaningController;
    _explanationController = widget.explanationController;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 項目フォーム
        TextFormField(
          controller: _entryController,
          decoration: const InputDecoration(
              labelText: "項目名", hintText: '項目名を入力してください。'),
          validator: (value) {
            if (value!.isEmpty) {
              return '項目名は空欄にできません。';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        // 意味フォーム
        TextFormField(
          controller: _meaningController,
          decoration: const InputDecoration(
              labelText: "主な意味", hintText: '主な意味を入力してください。'),
          validator: (value) {
            if (value!.isEmpty) {
              return '意味は空欄にできません。';
            }
            return null;
          },
        ),
        const SizedBox(height: 40),
        // 解説フォーム
        TextFormField(
          // 複数行のフォーム。 参考： https://stackoverflow.com/questions/54972928/how-to-expand-a-textfield-in-flutter-looks-like-a-text-area
          minLines: 8,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: _explanationController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '解説',
            hintText: '【空欄可】解説があれば入力してください。',
          ),
        ),
        WordFormPreviewButton(
            entryController: _entryController!,
            meaningController: _meaningController!,
            explanationController: _explanationController!,
            dictionary: widget.dictionary)
      ],
    );
  }
}
