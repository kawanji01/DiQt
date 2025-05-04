import 'package:booqs_mobile/components/form/editor_comment.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
import 'package:booqs_mobile/components/shared/ssml/ssml_form.dart';
import 'package:booqs_mobile/data/provider/sentence.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceFormFields extends ConsumerWidget {
  const SentenceFormFields({
    super.key,
    required this.dictionary,
    this.isNew = false,
    this.keyword = '',
  });
  final Dictionary dictionary;
  final bool isNew;
  final String? keyword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, TextEditingController> sentenceControllerMap =
        ref.watch(sentenceControllerMapProvider);
    final TextEditingController originalController =
        sentenceControllerMap['original'] ?? TextEditingController();
    final TextEditingController originalSsmlController =
        sentenceControllerMap['original_ssml'] ?? TextEditingController();
    final TextEditingController translationController =
        sentenceControllerMap['translation'] ?? TextEditingController();
    final TextEditingController jaTranslationController =
        sentenceControllerMap['ja_translation'] ?? TextEditingController();
    final TextEditingController explanationController =
        sentenceControllerMap['explanation'] ?? TextEditingController();
    final TextEditingController commentController =
        sentenceControllerMap['comment'] ?? TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SharedItemLabel(
            text: '${t.sentences.original}(${dictionary.languageOfEntry()})'),
        const SizedBox(height: 16),
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
        SharedSsmlForm(
          ssmlController: originalSsmlController,
          textController: originalController,
          dictionary: dictionary,
          label: t.sentences.original_ssml,
        ),
        const SizedBox(height: 40),
        SharedItemLabel(text: t.sentences.translation),
        const SizedBox(height: 16),
        TextFormField(
          controller: translationController,
          minLines: 3,
          keyboardType: TextInputType.multiline,
          maxLines: 8,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: t.sentences.translation,
              hintText: t.sentences.translation_placeholder(
                  language: dictionary.languageOfMeaning())),
          validator: (value) {
            if (value!.isEmpty) {
              return t.errors.cant_be_blank;
            }
            return null;
          },
        ),
        const SizedBox(height: 40),
        SharedItemLabel(text: t.sentences.ja_translation),
        const SizedBox(height: 16),
        TextFormField(
          controller: jaTranslationController,
          minLines: 3,
          keyboardType: TextInputType.multiline,
          maxLines: 8,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: t.sentences.ja_translation,
              hintText: ''),
        ),
        const SizedBox(height: 40),
        SharedItemLabel(text: t.sentences.explanation),
        const SizedBox(height: 16),
        TextFormField(
          controller: explanationController,
          minLines: 2,
          keyboardType: TextInputType.multiline,
          maxLines: 6,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: t.sentences.explanation,
              hintText: ''),
        ),
        const SizedBox(height: 40),
        FormEditorComment(
            commentController: commentController, emptyValidation: false),
        const SizedBox(height: 40),
      ],
    );
  }
}
