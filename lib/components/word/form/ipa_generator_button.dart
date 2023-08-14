import 'package:booqs_mobile/components/word/form/ipa_generator_screen.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';

class WordFormIPAGeneratorButton extends StatefulWidget {
  const WordFormIPAGeneratorButton(
      {super.key,
      required this.ipaController,
      required this.entryController,
      required this.dictionary});
  final TextEditingController ipaController;
  final TextEditingController entryController;
  final Dictionary dictionary;

  @override
  State<WordFormIPAGeneratorButton> createState() =>
      _WordFormIPAGeneratorButtonState();
}

class _WordFormIPAGeneratorButtonState
    extends State<WordFormIPAGeneratorButton> {
  final _regionalPronunciationController = TextEditingController(text: 'false');
  final _aiModelController = TextEditingController(text: '3');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _regionalPronunciationController.dispose();
    _aiModelController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        minimumSize: const Size(double.infinity, 40),
      ),
      icon: const Icon(Icons.auto_fix_high, color: Colors.white),
      label: Text(
        t.words.generate_ipa_with_ai,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      onPressed: () {
        // ボタンを押したときのTextFieldのフォーカスが解除する。
        // これをしないとモーダルを閉じたときに、画面がTextFieldまで移動してしまい不便。
        FocusScope.of(context).unfocus();
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)),
          ),
          builder: (context) => WordFormIPAGeneratorScreen(
              ipaController: widget.ipaController,
              entryController: widget.entryController,
              regionalPronunciationController: _regionalPronunciationController,
              aiModelController: _aiModelController,
              dictionary: widget.dictionary),
        );
      },
    );
  }
}
