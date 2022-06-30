import 'dart:async';
import 'package:booqs_mobile/data/remote/words.dart';

// 参考： https://ichi.pro/flutter-de-o-tokonpuri-to-kino-o-jissosuru-hoho-209603487537223
class WordTypeahead {
  // ユーザーが検索フォームに入力したキーワードから、辞書の項目をサジェストする
  static Future<List<String>> getSuggestions(
      String query, int dictionaryId) async {
    List<String> _entries = [];

    if (query.isEmpty && query.length < 3) {
      print('Query needs to be at least 3 chars');
      return Future.value([]);
    }

    final Map? resMap = await RemoteWords.autocomplete(dictionaryId, query);

    if (resMap != null) {
      resMap['entries'].forEach((entry) => _entries.add(entry));
    }

    return Future.value(_entries);
  }
}
