import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/components/sentence/form/keyword.dart';
import 'package:booqs_mobile/components/sentence/form/meaning.dart';
import 'package:booqs_mobile/components/sentence/form/pos_tag.dart';
import 'package:booqs_mobile/components/sentence/form/sentence_type.dart';
import 'package:booqs_mobile/components/sentence/form/temperature.dart';
import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SentenceFormGeneratorScreen extends StatefulWidget {
  const SentenceFormGeneratorScreen(
      {Key? key,
      required this.originalController,
      required this.keywordController,
      required this.posTagIdController,
      required this.meaningController,
      required this.sentenceTypeController,
      required this.temperatureController,
      required this.dictionary})
      : super(key: key);
  final TextEditingController originalController;
  final TextEditingController keywordController;
  final TextEditingController posTagIdController;
  final TextEditingController meaningController;
  final TextEditingController sentenceTypeController;
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
    final TextEditingController originalController = widget.originalController;
    final TextEditingController keywordController = widget.keywordController;
    final TextEditingController posTagIdController = widget.posTagIdController;
    final TextEditingController meaningController = widget.meaningController;
    final TextEditingController sentenceTypeController =
        widget.sentenceTypeController;
    final TextEditingController temperatureController =
        widget.temperatureController;

    Future generate() async {
      // 各Fieldのvalidatorを呼び出す
      if (!_formKey.currentState!.validate()) return;
      // リクエストロック開始
      setState(() {
        _isRequesting = true;
      });

      try {
        // 画面全体にローディングを表示
        EasyLoading.show(status: 'loading...');
        final Map? resMap = await RemoteSentences.generate(
            keywordController.text,
            dictionaryId,
            posTagIdController.text,
            meaningController.text,
            sentenceTypeController.text,
            temperatureController.text);
        EasyLoading.dismiss();
        // リクエストロック終了
        setState(() {
          _isRequesting = false;
        });
        if (!mounted) return;
        if (resMap == null) {
          final snackBar =
              SnackBar(content: Text(t.sentences.generating_sentence_failed));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          final String? original = resMap['original'];
          originalController.text = original ?? '';
          final snackBar =
              SnackBar(content: Text(t.sentences.sentence_generated));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pop(context);
        }
      } catch (e) {
        print(e);
        final snackBar = SnackBar(content: Text(t.errors.error_occured));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                    keywordController: keywordController,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  // 品詞
                  SentenceFormPosTag(
                    posTagIdController: posTagIdController,
                    posTags: widget.dictionary.posTags,
                  ),
                  const SizedBox(
                    height: 24,
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
                          height: 24,
                        ),
                        // 意味
                        SentenceFormMeaning(
                          meaningController: meaningController,
                          dictionary: dictionary,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        // 文の種類
                        SentenceFormSentenceType(
                          sentenceTypeController: sentenceTypeController,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        // temperature
                        SentenceFormTemperature(
                          temperatureController: temperatureController,
                        ),
                      ]),
                  const SizedBox(height: 40),
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
