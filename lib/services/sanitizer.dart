class Sanitizer {
  static String removeDiQtLink(String text) {
    // テキストを、正規表現でキャプチャーして置き換える。
    // ref: https://stackoverflow.com/questions/62754405/flutter-dart-regex-replace-with-2
    // ref: https://api.flutter.dev/flutter/dart-core/String/replaceAllMapped.html
    text = text.replaceAllMapped(RegExp(r'\[{2}(.*?)\|.*?\]{2}'), (match) {
      return '${match.group(1)}';
    });
    text = text.replaceAll(RegExp(r'(\[{2}|\]{2})'), '');
    return text;
  }
}
