import 'package:booqs_mobile/utils/booqs_on_web.dart';
import 'package:flutter/material.dart';

class SentenceEditButton extends StatelessWidget {
  const SentenceEditButton({Key? key, required this.sentenceId})
      : super(key: key);
  final int sentenceId;

  @override
  Widget build(BuildContext context) {
    final String redirectPath = '/sentences/$sentenceId/edit';

    return Container(
      // 左寄せ
      alignment: Alignment.topLeft,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          primary: Colors.black54,
          textStyle: const TextStyle(fontSize: 14),
        ),
        onPressed: () {
          BooQsOnWeb.open(context, redirectPath);
        },
        child: const Text(
          'この例文を改善する',
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
