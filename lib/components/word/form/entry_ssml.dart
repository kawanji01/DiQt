import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';
import 'package:booqs_mobile/components/shared/ssml/ssml_form.dart';

class WordFormEntrySsml extends StatelessWidget {
  const WordFormEntrySsml({
    super.key,
    required this.entrySsmlController,
    required this.entryController,
    required this.dictionary,
  });
  final TextEditingController entrySsmlController;
  final TextEditingController entryController;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    return SharedSsmlForm(
      ssmlController: entrySsmlController,
      textController: entryController,
      dictionary: dictionary,
      label: t.words.entry_ssml,
    );
  }
}
