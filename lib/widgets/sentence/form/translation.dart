import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/widgets/sentence/form/translation_buttons.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/shared/lang_setting.dart';
import 'package:flutter/material.dart';

class SentenceFormTranslation extends StatelessWidget {
  const SentenceFormTranslation({
    Key? key,
    required this.translationController,
    required this.dictionary,
    required this.originalController,
  }) : super(key: key);
  final TextEditingController translationController;
  final Dictionary dictionary;
  final TextEditingController originalController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SharedItemLabel(text: '翻訳'),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: translationController,
          minLines: 3,
          keyboardType: TextInputType.multiline,
          maxLines: 8,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "例文の訳",
              hintText: '例文の訳を入力してください。'),
          validator: (value) {
            if (value!.isEmpty) {
              return '例文の翻訳は空欄にできません。';
            }
            return null;
          },
        ),
        SharedLangSetting(langNumber: dictionary.langNumberOfMeaning),
        SentenceFormTranslationButtons(
          originalController: originalController,
          translationController: translationController,
          sourceLangNumber: dictionary.langNumberOfEntry,
          targetLangNumber: dictionary.langNumberOfMeaning,
        )
      ],
    );
  }
}
