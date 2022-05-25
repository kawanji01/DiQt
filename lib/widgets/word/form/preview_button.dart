import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/widgets/word/form/preview_screen.dart';
import 'package:flutter/material.dart';

class WordFormPreviewButton extends StatelessWidget {
  const WordFormPreviewButton(
      {Key? key,
      required this.entryController,
      required this.meaningController,
      required this.explanationController,
      required this.dictionary})
      : super(key: key);
  final TextEditingController entryController;
  final TextEditingController meaningController;
  final TextEditingController explanationController;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(left: 0),
        textStyle: const TextStyle(
          fontSize: 14,
        ),
      ),
      onPressed: () {
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
            builder: (context) => WordFormPreviewScreen(
                entry: entryController.text,
                meaning: meaningController.text,
                explanation: explanationController.text,
                dictionary: dictionary));
      },
      child: const Text('プレビューを見る', style: TextStyle(color: Colors.green)),
    );
  }
}
