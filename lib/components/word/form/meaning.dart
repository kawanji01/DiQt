import 'package:booqs_mobile/components/markdown/introduction_text_button.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/word/form/meaning_generator_button.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/language_handler.dart';
import 'package:flutter/material.dart';

class WordFormMeaning extends StatelessWidget {
  const WordFormMeaning(
      {super.key,
      required this.meaningController,
      required this.entryController,
      required this.posTagIdController,
      required this.dictionary});
  final TextEditingController meaningController;
  final TextEditingController entryController;
  final TextEditingController posTagIdController;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    final String language =
        LanguageHandler.getLanguageFromNumber(dictionary.langNumberOfMeaning);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedItemLabel(text: '${t.words.meaning} ($language)'),
        const SizedBox(height: 16),
        // 意味フォーム
        TextFormField(
          // [Flutter/Dart]入力欄（TextField）で折返し表示させる方法 ref: https://minpro.net/flutter-dart-textfield-fold
          maxLines: null,
          controller: meaningController,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: '【${t.shared.required}】${t.words.meaning}',
              hintText: t.shared.please_enter(name: t.words.meaning)),
          validator: (value) {
            if (value!.isEmpty) {
              return t.errors.cant_be_blank;
            }
            return null;
          },
        ),
        const MarkdownIntroductionTextButton(),
        //WordFormLangSetting(langNumber: dictionary.langNumberOfMeaning),
        const SizedBox(height: 16),
        // 意味生成ボタン
        WordFormMeaningGeneratorButton(
          entry: entryController.text,
          meaningController: meaningController,
          posTagIdController: posTagIdController,
          dictionary: dictionary,
        ),
      ],
    );
  }
}
