import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/word/edit.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordItemEditButton extends ConsumerWidget {
  const WordItemEditButton({Key? key, required this.word, required this.isShow})
      : super(key: key);
  final Word word;
  final bool isShow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 編集ボタン
    Widget editButton() {
      return Align(
        alignment: Alignment.topLeft,
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black54,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            textStyle: const TextStyle(fontSize: 15),
          ),
          onPressed: () {
            ref.read(wordProvider.notifier).state = word;
            WordEditPage.push(context, word.id);
          },
          child: Text(
            t.words.edit,
            style: const TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }

    if (isShow) return editButton();

    // 単語ページボタン
    Widget showButton() {
      return Align(
        alignment: Alignment.topRight,
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black54,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            textStyle: const TextStyle(fontSize: 15),
          ),
          onPressed: () {
            WordShowPage.push(context, word.id);
          },
          child: Text(
            t.shared.details,
            style: const TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [editButton(), showButton()],
    );
  }
}
