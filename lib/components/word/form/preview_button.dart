import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/components/word/form/preview_screen.dart';
import 'package:flutter/material.dart';

class WordFormPreviewButton extends StatelessWidget {
  const WordFormPreviewButton(
      {Key? key,
      required this.entryController,
      required this.meaningController,
      required this.ipaController,
      required this.sentenceIdController,
      required this.etymologiesController,
      required this.explanationController,
      required this.synonymsController,
      required this.antonymsController,
      required this.relatedController,
      required this.dictionary})
      : super(key: key);
  final TextEditingController entryController;
  final TextEditingController meaningController;
  final TextEditingController ipaController;
  final TextEditingController sentenceIdController;
  final TextEditingController etymologiesController;
  final TextEditingController explanationController;
  final TextEditingController synonymsController;
  final TextEditingController antonymsController;
  final TextEditingController relatedController;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.visibility, color: Colors.green),
      label: Text(
        t.words.text_preview,
        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
      ),
      onPressed: () {
        int? sentenceId;
        if (sentenceIdController.text != 'null') {
          sentenceId = int.parse(sentenceIdController.text);
        }
        // プレビューするwordを生成する
        final Word word = Word(
          id: 0,
          entry: entryController.text,
          meaning: meaningController.text,
          ipa: ipaController.text,
          sentenceId: sentenceId,
          etymologies: etymologiesController.text,
          explanation: explanationController.text,
          synonyms: synonymsController.text,
          antonyms: antonymsController.text,
          related: relatedController.text,
          dictionaryId: dictionary.id,
          langNumberOfEntry: dictionary.langNumberOfEntry,
          langNumberOfMeaning: dictionary.langNumberOfMeaning,
          acceptedWordRequestsCount: 0,
          pendingWordRequestsCount: 0,
          wordRequestsCount: 0,
        );

        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
            ),
            builder: (context) =>
                WordFormPreviewScreen(word: word, dictionary: dictionary));
      },
    );
  }
}
