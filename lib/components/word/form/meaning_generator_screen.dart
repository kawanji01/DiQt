import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/components/sentence/form/ai_model.dart';
import 'package:booqs_mobile/components/word/form/pos_tag.dart';
import 'package:booqs_mobile/data/remote/words.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class WordFormMeaningGeneratorScreen extends StatefulWidget {
  const WordFormMeaningGeneratorScreen(
      {super.key,
      required this.keywordController,
      required this.posTagIdController,
      required this.meaningController,
      required this.aiModelController,
      required this.dictionary});
  final TextEditingController keywordController;
  final TextEditingController posTagIdController;
  final TextEditingController meaningController;
  final TextEditingController aiModelController;
  final Dictionary dictionary;

  @override
  State<WordFormMeaningGeneratorScreen> createState() =>
      _WordFormMeaningGeneratorScreenState();
}

class _WordFormMeaningGeneratorScreenState
    extends State<WordFormMeaningGeneratorScreen> {
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
    final TextEditingController keywordController = widget.keywordController;

    final TextEditingController aiModelController = widget.aiModelController;

    Future generate() async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;
      // リクエストロック開始
      setState(() {
        _isRequesting = true;
      });

      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map resMap = await RemoteWords.generateMeaning(
        keyword: keywordController.text,
        dictionaryId: dictionaryId,
        posTagId: widget.posTagIdController.text,
        model: aiModelController.text,
      );
      EasyLoading.dismiss();
      // リクエストロック終了
      setState(() {
        _isRequesting = false;
      });
      if (!mounted) return;
      if (ErrorHandler.isErrorMap(resMap)) {
        ErrorHandler.showErrorSnackBar(context, resMap);
        Navigator.pop(context);
      } else {
        final String meaning = resMap['meaning'] ?? '';
        widget.meaningController.text = meaning;
        final snackBar =
            SnackBar(content: Text(t.words.success_to_generate_meanings));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pop();
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
                    label: t.words.generate_meaning_with_ai,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  // キーワードフォーム
                  TextFormField(
                    controller: keywordController,
                    decoration: InputDecoration(
                      labelText: t.words.meaning_generation_keyword_placeholder,
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          keywordController.clear();
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return t.errors.cant_be_blank;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  // 品詞
                  WordFormPosTag(
                    posTagIdController: widget.posTagIdController,
                    posTags: dictionary.posTags,
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 48,
                  ),

                  // AIモデル
                  SentenceFormAIModel(
                    aiModelController: aiModelController,
                  ),

                  const SizedBox(height: 64),
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
