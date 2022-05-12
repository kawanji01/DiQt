import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/word/edit.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordEditButton extends ConsumerWidget {
  const WordEditButton({Key? key, required this.word, required this.isShow})
      : super(key: key);
  final Word word;
  final bool isShow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget _editButton() {
      return Container(
        // 左寄せ
        alignment: Alignment.topLeft,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            primary: Colors.black54,
            textStyle: const TextStyle(fontSize: 16),
          ),
          onPressed: () {
            WordEditPage.push(context, word.id);
          },
          child: const Text(
            'この項目を改善する',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }

    if (isShow) return _editButton();

    Widget _showButton() {
      return Container(
        // 左寄せ
        alignment: Alignment.topRight,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            primary: Colors.black54,
            textStyle: const TextStyle(fontSize: 16),
          ),
          onPressed: () {
            WordShowPage.push(context, word.id);
          },
          child: const Text(
            '詳細',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_editButton(), _showButton()],
    );
  }
}
