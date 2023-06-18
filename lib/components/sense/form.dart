import 'package:booqs_mobile/components/sense/form/preview_button.dart';
import 'package:booqs_mobile/components/sentence/setting/setting.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/shared/lang_setting.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class SenseForm extends StatefulWidget {
  const SenseForm({
    Key? key,
    required this.glossController,
    required this.sentenceIdController,
    required this.word,
    required this.dictionary,
    required this.isNew,
    this.keyword,
  }) : super(key: key);

  final TextEditingController glossController;
  final TextEditingController sentenceIdController;
  final bool isNew;
  final String? keyword;
  final Word word;
  final Dictionary dictionary;

  @override
  State<SenseForm> createState() => _SenseFormState();
}

class _SenseFormState extends State<SenseForm> {
  late TextEditingController _glossController;
  late TextEditingController _sentenceIdController;
  final TextEditingController _posTagIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _glossController = widget.glossController;
    _sentenceIdController = widget.sentenceIdController;
    _posTagIdController.text = '${widget.word.posTagId}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 例文フォーム
        const SharedItemLabel(text: '意味'),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: _glossController,
          minLines: 3,
          keyboardType: TextInputType.multiline,
          maxLines: 8,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "意味",
              hintText: '意味を入力してください。'),
          validator: (value) {
            if (value!.isEmpty) {
              return t.errors.cant_be_blank;
            }
            return null;
          },
        ),
        SharedLangSetting(langNumber: widget.dictionary.langNumberOfMeaning),

        const SizedBox(height: 24),
        SentenceSetting(
          sentenceIdController: _sentenceIdController,
          entry: '${widget.keyword}',
          dictionary: widget.dictionary,
          posTagIdController: _posTagIdController,
        ),

        const SizedBox(height: 40),
        SenseFormPreviewButton(
            glossController: _glossController,
            sentenceIdController: _sentenceIdController,
            word: widget.word),
      ],
    );
  }
}
