import 'package:booqs_mobile/components/sense/form/preview_screen.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';

class SenseFormPreviewButton extends StatelessWidget {
  const SenseFormPreviewButton(
      {Key? key,
      required this.glossController,
      required this.sentenceIdController,
      required this.word})
      : super(key: key);
  final TextEditingController glossController;
  final TextEditingController sentenceIdController;
  final Word word;

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
            builder: (context) => SenseFormPreviewScreen(
                gloss: glossController.text,
                sentenceIdStr: sentenceIdController.text,
                word: word))
      },
      icon: const Icon(Icons.visibility, color: Colors.white),
      label: const Text(
        'プレビューを見る',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
