import 'package:booqs_mobile/components/button/small_green_button.dart';
import 'package:booqs_mobile/components/sentence/form/generator_screen.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';

class SentenceFormGeneratorButton extends StatefulWidget {
  const SentenceFormGeneratorButton(
      {Key? key,
      required this.originalController,
      required this.keyword,
      required this.dictionary})
      : super(key: key);
  final TextEditingController originalController;
  final String? keyword;
  final Dictionary dictionary;

  @override
  State<SentenceFormGeneratorButton> createState() =>
      _SentenceFormGeneratorButtonState();
}

class _SentenceFormGeneratorButtonState
    extends State<SentenceFormGeneratorButton> {
  final _keywordController = TextEditingController();
  final _posTagIdController = TextEditingController();
  final _meaningController = TextEditingController();
  final _sentenceTypeController = TextEditingController();
  final _difficultyController = TextEditingController();
  final _aiModelController = TextEditingController();
  final _temperatureController = TextEditingController();

  @override
  void initState() {
    _keywordController.text = widget.keyword ?? '';
    _posTagIdController.text = '';
    _meaningController.text = '';
    _sentenceTypeController.text = '';
    _temperatureController.text = '7';
    super.initState();
  }

  @override
  void dispose() {
    _keywordController.dispose();
    _posTagIdController.dispose();
    _meaningController.dispose();
    _sentenceTypeController.dispose();
    _temperatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              // 丸み ref: https://www.codegrepper.com/code-examples/whatever/showmodalbottomsheet+rounded+corners
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
              ),
              // showModalBottomSheetで表示される中身
              builder: (context) => SentenceFormGeneratorScreen(
                    originalController: widget.originalController,
                    keywordController: _keywordController,
                    posTagIdController: _posTagIdController,
                    meaningController: _meaningController,
                    sentenceTypeController: _sentenceTypeController,
                    difficultyController: _difficultyController,
                    aiModelController: _aiModelController,
                    temperatureController: _temperatureController,
                    dictionary: widget.dictionary,
                  ));
        },
        child: SmallGreenButton(
            label: t.sentences.generate_sentence, icon: Icons.auto_fix_high));
  }
}
