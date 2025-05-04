import 'package:booqs_mobile/components/form/editor_comment.dart';
import 'package:booqs_mobile/components/sentence/form/original.dart';
import 'package:booqs_mobile/components/sentence/form/original_ssml.dart';
import 'package:booqs_mobile/components/sentence/form/preview_button.dart';
import 'package:booqs_mobile/components/sentence/form/translation.dart';
import 'package:booqs_mobile/components/sentence/form/ja_translation.dart';
import 'package:booqs_mobile/components/shared/item_label.dart';
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
        SentenceFormOriginal(
          originalController: originalController,
          translationController: translationController,
          dictionary: dictionary,
          isNew: isNew,
          keyword: keyword,
        ),
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
        SentenceFormPreviewButton(
          originalController: originalController,
          translationController: translationController,
          explanationController: explanationController,
          dictionary: dictionary,
        ),
      ],
    );
  }
}
