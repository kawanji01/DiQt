import 'package:booqs_mobile/components/form/editor_comment.dart';
import 'package:booqs_mobile/components/form/white_text_form_field.dart';
import 'package:booqs_mobile/components/sentence/setting/setting.dart';
import 'package:booqs_mobile/components/word/form/meaning_generator_button.dart';
import 'package:booqs_mobile/components/word/form/pos_tag.dart';
import 'package:booqs_mobile/components/word/form/senses.dart';
import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/components/word/form/lang_setting.dart';
import 'package:booqs_mobile/components/word/form/reading.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordFormFields extends ConsumerWidget {
  const WordFormFields(
      {Key? key,
      required this.word,
      required this.dictionary,
      required this.commentController})
      : super(key: key);
  final Word? word;
  final Dictionary dictionary;
  final TextEditingController commentController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, TextEditingController> wordControllerMap =
        ref.watch(wordControllerMapProvider);
    final TextEditingController entryController =
        wordControllerMap['entry'] ?? TextEditingController();
    final TextEditingController readingController =
        wordControllerMap['reading'] ?? TextEditingController();
    final TextEditingController meaningController =
        wordControllerMap['meaning'] ?? TextEditingController();
    final TextEditingController posTagIdController =
        wordControllerMap['pos_tag_id'] ?? TextEditingController();
    final TextEditingController sentenceIdController =
        wordControllerMap['sentence_id'] ?? TextEditingController();
    final TextEditingController ipaController =
        wordControllerMap['ipa'] ?? TextEditingController();

    print('entry: ${entryController.text}');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 項目フォーム
        FormWhiteTextFormField(
          controller: entryController,
          label: t.words.entry,
          hint: t.shared.please_enter(name: t.words.entry),
          emptyValidation: true,
          lineBreak: false,
        ),
        /* TextFormField(
          controller: wordControllerMap['entry'],
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: t.words.entry,
              hintText: t.shared.please_enter(name: t.words.entry)),
          validator: (value) {
            if (value!.isEmpty) {
              return t.errors.cant_be_blank;
            }
            return null;
          },
        ), */
        WordFormReading(
          readingController: readingController,
          langNumberOfEntry: dictionary.langNumberOfEntry,
        ),
        WordFormLangSetting(langNumber: dictionary.langNumberOfEntry),
        const SizedBox(height: 16),
        // 品詞設定
        WordFormPosTag(
          posTagIdController: posTagIdController,
          posTags: dictionary.posTags,
          enabled: true,
        ),
        const SizedBox(height: 48),
        // 意味フォーム
        TextFormField(
          // [Flutter/Dart]入力欄（TextField）で折返し表示させる方法 ref: https://minpro.net/flutter-dart-textfield-fold
          maxLines: null,
          controller: meaningController,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: t.words.meaning,
              hintText: t.shared.please_enter(name: t.words.meaning)),
          validator: (value) {
            if (value!.isEmpty) {
              return t.errors.cant_be_blank;
            }
            return null;
          },
        ),
        WordFormLangSetting(langNumber: dictionary.langNumberOfMeaning),
        const SizedBox(height: 16),
        // 意味生成ボタン
        WordFormMeaningGeneratorButton(
          entry: entryController.text,
          meaningController: meaningController,
          posTagIdController: posTagIdController,
          dictionary: dictionary,
        ),
        const SizedBox(height: 48),

        // 例文設定
        SentenceSetting(
          sentenceIdController: sentenceIdController,
          entry: entryController.text,
          dictionary: dictionary,
          posTagIdController: posTagIdController,
        ),
        const SizedBox(height: 48),
        // IPA
        FormWhiteTextFormField(
          controller: ipaController,
          label: t.words.ipa,
          hint: t.shared.please_enter(name: t.words.ipa),
          emptyValidation: false,
          lineBreak: false,
        ),

        const SizedBox(height: 48),
        WordFormSenses(
          word: word,
        ),
        const SizedBox(height: 48),
        FormEditorComment(
          commentController: commentController,
        ),

        const SizedBox(height: 48),
      ],
    );
  }
}
