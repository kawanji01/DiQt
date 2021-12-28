import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/word/edit.dart';
import 'package:booqs_mobile/widgets/session/external_link_dialog.dart';
import 'package:flutter/material.dart';

class WordEditButton extends StatelessWidget {
  const WordEditButton({Key? key, required this.word}) : super(key: key);
  final Word? word;

  @override
  Widget build(BuildContext context) {
    // 編集ページへの遷移
    Future _moveToWordEdit(word) async {
      final int id = word.id;
      // 外部リンクダイアログを表示
      await showDialog(
          context: context,
          builder: (context) {
            return ExternalLinkDialog(redirectPath: 'words/$id/edit');
          });
      //await WordEditPage.push(context, word);
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
