import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/components/sentence/form/preview_screen.dart';
import 'package:flutter/material.dart';

class SentenceFormPreviewButton extends StatelessWidget {
  const SentenceFormPreviewButton(
      {Key? key,
      required this.originalController,
      required this.translationController,
      required this.explanationController,
      required this.dictionary})
      : super(key: key);
  final TextEditingController originalController;
  final TextEditingController translationController;
  final TextEditingController explanationController;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        minimumSize: const Size(double.infinity,
            40), // 親要素まで横幅を広げる。参照： https://stackoverflow.com/questions/50014342/how-to-make-button-width-match-parent
      ),
      onPressed: () => {
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
            builder: (context) => SentenceFormPreviewScreen(
                original: originalController.text,
                translation: translationController.text,
                explanation: explanationController.text,
                dictionary: dictionary))
      },
      icon: const Icon(Icons.visibility, color: Colors.white),
      label: const Text(
        'プレビューを見る',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
