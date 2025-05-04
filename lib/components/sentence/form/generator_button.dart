import 'package:booqs_mobile/components/button/small_outline_green_button.dart';
import 'package:booqs_mobile/components/sentence/form/generator_screen.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';

class SentenceFormGeneratorButton extends StatefulWidget {
  const SentenceFormGeneratorButton(
      {super.key,
      required this.originalController,
      required this.originalSsmlController,
      required this.translationController,
      required this.keyword,
      required this.dictionary});
  final TextEditingController originalController;
  final TextEditingController originalSsmlController;
  final TextEditingController translationController;
  final String? keyword;
  final Dictionary dictionary;

  @override
  State<SentenceFormGeneratorButton> createState() =>
      _SentenceFormGeneratorButtonState();
}

class _SentenceFormGeneratorButtonState
    extends State<SentenceFormGeneratorButton> {
  final _keywordController = TextEditingController();
  final _posTagIdController = TextEditingController(text: '');
  final _meaningController = TextEditingController(text: '');
  final _sentenceTypeController = TextEditingController(text: '');
  final _difficultyController = TextEditingController(text: '');
  final _keepingFormController = TextEditingController(text: '');
  final _aiModelController = TextEditingController(text: '3');
  final _temperatureController = TextEditingController(text: '7');

  @override
  void initState() {
    _keywordController.text = widget.keyword ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _keywordController.dispose();
    _posTagIdController.dispose();
    _meaningController.dispose();
    _sentenceTypeController.dispose();
    _difficultyController.dispose();
    _keepingFormController.dispose();
    _aiModelController.dispose();
    _temperatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // ボタンを押したときのTextFieldのフォーカスが解除する。
          // これをしないとモーダルを閉じたときに、画面がTextFieldまで移動してしまい不便。
          FocusScope.of(context).unfocus();
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
              ),
              builder: (context) => SentenceFormGeneratorScreen(
                    originalController: widget.originalController,
                    originalSsmlController: widget.originalSsmlController,
                    translationController: widget.translationController,
                    keywordController: _keywordController,
                    posTagIdController: _posTagIdController,
                    meaningController: _meaningController,
                    sentenceTypeController: _sentenceTypeController,
                    difficultyController: _difficultyController,
                    keepingFormController: _keepingFormController,
                    temperatureController: _temperatureController,
                    dictionary: widget.dictionary,
                  ));
        },
        child: SmallOutlineGreenButton(
            label: t.sentences.generate_sentence, icon: Icons.auto_fix_high));
  }
}
