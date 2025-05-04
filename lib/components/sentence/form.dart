import 'package:booqs_mobile/components/form/editor_comment.dart';
import 'package:booqs_mobile/components/sentence/form/ja_translation.dart';
import 'package:booqs_mobile/components/sentence/form/original_ssml.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/components/sentence/form/generator_button.dart';
import 'package:booqs_mobile/components/sentence/form/preview_button.dart';
import 'package:booqs_mobile/components/sentence/form/translation.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:flutter/material.dart';

class SentenceForm extends StatelessWidget {
  const SentenceForm({
    super.key,
    required this.originalController,
    required this.originalSsmlController,
    required this.translationController,
    required this.jaTranslationController,
    required this.explanationController,
    required this.commentController,
    required this.dictionary,
    required this.isNew,
    this.keyword,
  });

  final TextEditingController originalController;
  final TextEditingController originalSsmlController;
  final TextEditingController translationController;
  final TextEditingController jaTranslationController;
  final TextEditingController explanationController;
  final TextEditingController commentController;
  final bool isNew;
  final String? keyword;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    Widget sentenceGeneratorButton() {
      if (isNew) {
        return SentenceFormGeneratorButton(
          originalController: originalController,
          translationController: translationController,
          keyword: keyword,
          dictionary: dictionary,
        );
      }
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 例文フォーム
        SharedItemLabel(
            text: '${t.sentences.original}(${dictionary.languageOfEntry()})'),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: originalController,
          minLines: 3,
          keyboardType: TextInputType.multiline,
          maxLines: 8,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: t.sentences.original,
              hintText: t.sentences.original_placeholder(
                  language: dictionary.languageOfEntry())),
          validator: (value) {
            if (value!.isEmpty) {
              return t.errors.cant_be_blank;
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        sentenceGeneratorButton(),
        const SizedBox(height: 24),
        SentenceFormOriginalSsml(
          originalSsmlController: originalSsmlController,
          originalController: originalController,
          dictionary: dictionary,
        ),
        const SizedBox(height: 40),
        SentenceFormTranslation(
          translationController: translationController,
          dictionary: dictionary,
          originalController: originalController,
        ),
        const SizedBox(height: 40),
        SentenceFormJaTranslation(
          jaTranslationController: jaTranslationController,
          dictionary: dictionary,
        ),
        const SizedBox(height: 40),
        FormEditorComment(
            commentController: commentController, emptyValidation: false),
        //SentenceFormDetails(
        //    explanationController: explanationController,
        //    commentController: commentController),
        const SizedBox(height: 40),
        SentenceFormPreviewButton(
            originalController: originalController,
            translationController: translationController,
            explanationController: explanationController,
            dictionary: dictionary),
      ],
    );
  }
}
