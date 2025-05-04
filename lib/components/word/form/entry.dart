import 'package:booqs_mobile/components/form/white_text_form_field.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/word/form/pos_tag.dart';
import 'package:booqs_mobile/components/word/form/reading.dart';
import 'package:booqs_mobile/components/word/form/ssml.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/language_handler.dart';
import 'package:flutter/material.dart';

class WordFormEntry extends StatelessWidget {
  const WordFormEntry(
      {super.key,
      required this.entryController,
      required this.entrySsmlController,
      required this.ipaController,
      required this.readingController,
      required this.posTagIdController,
      required this.dictionary});
  final TextEditingController entryController;
  final TextEditingController entrySsmlController;
  final TextEditingController ipaController;
  final TextEditingController readingController;
  final TextEditingController posTagIdController;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    final String language =
        LanguageHandler.getLanguageFromNumber(dictionary.langNumberOfEntry);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedItemLabel(text: '${t.words.entry} ($language)'),
        const SizedBox(height: 16),
        FormWhiteTextFormField(
          controller: entryController,
          label: '【${t.shared.required}】${t.words.entry}',
          hint: t.shared.please_enter(name: t.words.entry),
          emptyValidation: true,
          lineBreak: false,
        ),
        const SizedBox(height: 24),
        WordFormReading(
          ipaController: ipaController,
          readingController: readingController,
          entryController: entryController,
          dictionary: dictionary,
        ),
        const SizedBox(height: 24),
        WordFormSSML(
          ssmlController: entrySsmlController,
          entryController: entryController,
          dictionary: dictionary,
        ),
        // WordFormLangSetting(langNumber: dictionary.langNumberOfEntry),
        const SizedBox(height: 16),
        // 品詞設定
        WordFormPosTag(
          posTagIdController: posTagIdController,
          posTags: dictionary.posTags,
          enabled: true,
          posTagRequired: dictionary.posTagRequired,
        ),
      ],
    );
  }
}
