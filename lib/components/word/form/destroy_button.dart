import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/components/word/form/destroy_confirmation_screen.dart';
import 'package:flutter/material.dart';

class WordFormDestroyButton extends StatelessWidget {
  const WordFormDestroyButton({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () {
          final Widget screen = WordFormDestroyConfirmationScreen(word: word);
          Dialogs.slideFromBottomFade(screen);
        },
        icon: const Icon(
          Icons.delete,
          size: 18,
          color: Colors.red,
        ),
        label: const Text('削除する',
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.normal)),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.only(left: 0),
        ),
      ),
    );
  }
}
