import 'package:booqs_mobile/widgets/sentence/preview_screen.dart';
import 'package:flutter/material.dart';

class SentencePreviewButton extends StatelessWidget {
  const SentencePreviewButton(
      {Key? key,
      required this.originalController,
      required this.translationController,
      required this.explanationController})
      : super(key: key);
  final TextEditingController originalController;
  final TextEditingController translationController;
  final TextEditingController explanationController;

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
            builder: (context) => SentencePreviewScreen(
                original: originalController.text,
                translation: translationController.text,
                explanation: explanationController.text));
      },
      child: const Text('プレビューを見る', style: TextStyle(color: Colors.green)),
    );
  }
}
