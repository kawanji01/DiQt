import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class WordFormComment extends StatelessWidget {
  const WordFormComment({super.key, required this.commentController});
  final TextEditingController commentController;

  @override
  Widget build(BuildContext context) {
    // コメント
    return TextFormField(
      // [Flutter/Dart]入力欄（TextField）で折返し表示させる方法 ref: https://minpro.net/flutter-dart-textfield-fold
      maxLines: null,
      controller: commentController,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: t.words.comment,
          hintText: t.words.comment_placeholder),
      validator: (value) {
        return null;
      },
    );
  }
}
