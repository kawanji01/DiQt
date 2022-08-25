import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/widgets/word/form/preview_screen.dart';
import 'package:flutter/material.dart';

class WordFormPreviewButton extends StatelessWidget {
  const WordFormPreviewButton(
      {Key? key,
      required this.entryController,
      required this.meaningController,
      required this.explanationController,
      required this.sentenceIdController,
      required this.dictionary})
      : super(key: key);
  final TextEditingController entryController;
  final TextEditingController meaningController;
  final TextEditingController explanationController;
  final TextEditingController sentenceIdController;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        minimumSize: const Size(double.infinity,
            40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
      ),
      icon: const Icon(Icons.visibility, color: Colors.white),
      label: const Text(
        'プレビューを見る',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
          explanation: explanationController.text,
          sentenceId: sentenceId,
          dictionaryId: dictionary.id,
          langNumberOfEntry: dictionary.langNumberOfEntry,
          langNumberOfMeaning: dictionary.langNumberOfMeaning,
        );

        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            // 丸み ref: https://www.codegrepper.com/code-examples/whatever/showmodalbottomsheet+rounded+corners
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
            ),
            // showModalBottomSheetで表示される中身
            builder: (context) =>
                WordFormPreviewScreen(word: word, dictionary: dictionary));
      },
    );
  }
}
