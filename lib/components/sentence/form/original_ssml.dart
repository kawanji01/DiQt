import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:booqs_mobile/components/shared/ssml/ssml_form.dart';
import 'package:booqs_mobile/models/dictionary.dart';

class SentenceFormOriginalSsml extends StatelessWidget {
  const SentenceFormOriginalSsml({
    super.key,
    required this.originalSsmlController,
    required this.originalController,
    required this.dictionary,
  });
  final TextEditingController originalSsmlController;
  final TextEditingController originalController;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    return SharedSsmlForm(
      ssmlController: originalSsmlController,
      textController: originalController,
      dictionary: dictionary,
      label: t.sentences.original_ssml,
    );
  }
}
