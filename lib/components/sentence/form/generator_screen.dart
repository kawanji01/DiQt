import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/components/sentence/form/difficulty.dart';
import 'package:booqs_mobile/components/sentence/form/keeping_form.dart';
import 'package:booqs_mobile/components/sentence/form/keyword.dart';
import 'package:booqs_mobile/components/sentence/form/meaning.dart';
import 'package:booqs_mobile/components/sentence/form/pos_tag.dart';
import 'package:booqs_mobile/components/sentence/form/sentence_type.dart';
import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SentenceFormGeneratorScreen extends StatefulWidget {
  const SentenceFormGeneratorScreen(
      {super.key,
      required this.originalController,
      required this.translationController,
      required this.keywordController,
      required this.posTagIdController,
      required this.meaningController,
      required this.sentenceTypeController,
      required this.difficultyController,
      required this.keepingFormController,
      required this.temperatureController,
      required this.dictionary});
  final TextEditingController originalController;
  final TextEditingController translationController;
  final TextEditingController keywordController;
  final TextEditingController posTagIdController;
  final TextEditingController meaningController;
  final TextEditingController sentenceTypeController;
  final TextEditingController difficultyController;
  final TextEditingController keepingFormController;
  final TextEditingController temperatureController;
  final Dictionary dictionary;

  @override
  State<SentenceFormGeneratorScreen> createState() =>
      _SentenceFormGeneratorScreenState();
}

class _SentenceFormGeneratorScreenState
    extends State<SentenceFormGeneratorScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isRequesting = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Dictionary dictionary = widget.dictionary;
    final int dictionaryId = dictionary.id;
    SizeConfig().init(context);
    final double grid = SizeConfig.blockSizeVertical ?? 0;
    final double height = grid * 80;

    Future generate() async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;
      // リクエストロック開始
      setState(() {
        _isRequesting = true;
      });

      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map resMap = await RemoteSentences.generateWithTranslation(
          keyword: widget.keywordController.text,
          dictionaryId: dictionaryId,
          posTagId: widget.posTagIdController.text,
          meaning: widget.meaningController.text,
          sentenceType: widget.sentenceTypeController.text,
          difficulty: widget.difficultyController.text,
          keepingForm: widget.keepingFormController.text,
          temperature: widget.temperatureController.text);
      EasyLoading.dismiss();
      // リクエストロック終了
      setState(() {
        _isRequesting = false;
      });
      if (!context.mounted) return;
      if (ErrorHandler.isErrorMap(resMap)) {
        ErrorHandler.showErrorSnackBar(context, resMap);
        Navigator.pop(context);
      } else {
        widget.originalController.text = resMap['original'] ?? '';
        widget.translationController.text = resMap['translation'] ?? '';
        final snackBar =
            SnackBar(content: Text(t.sentences.sentence_generated));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      }
    }

    return Container(
      height: height,
      padding: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context)),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  HeadingMediumGreen(
                    label: t.sentences.generate_sentence,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // キーワードフォーム
                  SentenceFormKeyword(
                    keywordController: widget.keywordController,
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  // 品詞
                  SentenceFormPosTag(
                    posTagIdController: widget.posTagIdController,
                    posTags: widget.dictionary.posTags,
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  // 詳細設定
                  ExpansionTile(
                      title: Text(
                        t.sentences.details,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      collapsedBackgroundColor: Colors.grey.shade200,
                      children: <Widget>[
                        const SizedBox(
                          height: 48,
                        ),
                        // 意味
                        SentenceFormMeaning(
                          meaningController: widget.meaningController,
                          dictionary: dictionary,
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        // 文の種類
                        SentenceFormSentenceType(
                          sentenceTypeController: widget.sentenceTypeController,
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        // 難易度
                        SentenceFormDifficulty(
                          difficultyController: widget.difficultyController,
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        // キーワードの変更有無
                        SentenceFormKeepingForm(
                          keepingFormController: widget.keepingFormController,
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        // temperature
                        /* SentenceFormTemperature(
                          temperatureController: temperatureController,
                        ), */
                      ]),
                  const SizedBox(height: 48),
                  InkWell(
                    onTap: _isRequesting
                        ? null
                        : () async {
                            generate();
                          },
                    child: MediumGreenButton(
                      fontSize: 18,
                      icon: Icons.auto_fix_high,
                      label: t.shared.generate,
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
