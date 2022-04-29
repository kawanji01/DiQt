import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/word/edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordEditButton extends ConsumerWidget {
  const WordEditButton({Key? key, required this.word}) : super(key: key);
  final Word? word;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 編集ページへの遷移
    Future _moveToWordEdit(word) async {
      ref.read(wordProvider.notifier).state = word;
      await WordEditPage.push(context);
    }

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
          _moveToWordEdit(word);
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
}
