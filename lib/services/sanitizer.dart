class Sanitizer {
  static String removeDiQtLink(String text) {
    // [[表示名>検索キーワード]] を 表示名 に置き換える。
    // ref: https://stackoverflow.com/questions/62754405/flutter-dart-regex-replace-with-2
    // ref: https://api.flutter.dev/flutter/dart-core/String/replaceAllMapped.html
    // ref: https://zenn.dev/kawanji01/articles/7757fdbbdb81bf
    text = text.replaceAllMapped(RegExp(r'\[{2}(.*?)\|.*?\]{2}'), (match) {
      return '${match.group(1)}';
    });
    // [[検索キーワード]] を 検索キーワード に置き換える
    text = text.replaceAll(RegExp(r'(\[{2}|\]{2})'), '');
    return text;
  }
}
