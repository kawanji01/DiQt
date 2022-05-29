import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/services/sanitizer.dart';
import 'package:booqs_mobile/widgets/shared/tts_button.dart';
import 'package:flutter/material.dart';

class SentenceTTSButton extends StatelessWidget {
  const SentenceTTSButton({Key? key, required this.sentence}) : super(key: key);
  final Sentence sentence;

  @override
  Widget build(BuildContext context) {
    // TTSできちんと読み上げるためにDiQtリンクを取り除いた平文を渡す
    final String originalPlainText =
        Sanitizer.removeDiQtLink(sentence.original);

    return Container(
      margin: const EdgeInsets.only(top: 4),
      alignment: Alignment.center,
      child: TtsButton(
        speechText: originalPlainText,
        langNumber: sentence.langNumberOfOriginal,
      ),
    );
  }
}
