import 'package:booqs_mobile/components/button/small_outline_green_button.dart';
import 'package:booqs_mobile/components/word/form/meaning_generator_screen.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';

class WordFormMeaningGeneratorButton extends StatefulWidget {
  const WordFormMeaningGeneratorButton(
      {super.key,
      required this.entry,
      required this.posTagIdController,
      required this.meaningController,
      required this.dictionary});
  final String entry;
  final TextEditingController posTagIdController;
  final TextEditingController meaningController;
  final Dictionary dictionary;

  @override
  State<WordFormMeaningGeneratorButton> createState() =>
      _WordFormMeaningGeneratorButtonState();
}

class _WordFormMeaningGeneratorButtonState
    extends State<WordFormMeaningGeneratorButton> {
  final _keywordController = TextEditingController();
  final _aiModelController = TextEditingController(text: '3');

  @override
  void initState() {
    super.initState();
    _keywordController.text = widget.entry;
  }

  @override
  void dispose() {
    super.dispose();
    _keywordController.dispose();
    _aiModelController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
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
            builder: (context) => WordFormMeaningGeneratorScreen(
                keywordController: _keywordController,
                posTagIdController: widget.posTagIdController,
                meaningController: widget.meaningController,
                dictionary: widget.dictionary),
          );
        },
        child: SmallOutlineGreenButton(
            label: t.words.generate_meaning_with_ai,
            icon: Icons.auto_fix_high));
  }
}
