import 'dart:async';
import 'package:booqs_mobile/models/word.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// 参考： https://ichi.pro/flutter-de-o-tokonpuri-to-kino-o-jissosuru-hoho-209603487537223
class WordTypeahead {
  // ユーザーが検索フォームに入力したキーワードから、辞書の項目をサジェストする
  static Future<List<String>> getSuggestions(
      String query, int? dictionaryId) async {
    List<Word> _words = [];

    if (query.isEmpty && query.length < 3) {
      print('Query needs to be at least 3 chars');
      return Future.value([]);
    }
    //var url = Uri.https('api.datamuse.com', '/sug', {'s': query});

    var url = Uri.parse(
        '${const String.fromEnvironment("ROOT_URL")}/api/v1/mobile/words/autocomplete');
    var res = await http
        .post(url, body: {'dictionary_id': '$dictionaryId', 'query': query});

    if (res.statusCode == 200) {
      print(res.body);
      // Convert JSON into map. ref: https://qiita.com/rkowase/items/f397513f2149a41b6dd2
      Map<String, dynamic> resMap = json.decode(res.body);
      if (resMap['data'] != null) {
        // Convert map to list. ref: https://qiita.com/7_asupara/items/01c29c006556e89f5b17
        resMap['data'].forEach((e) => _words.add(Word.fromJson(e)));
      }
      print('Number of suggestion: ${_words.length}.');
    } else {
      print('Request failed with status: ${res.statusCode}.');
    }
    print(_words);

    return Future.value(_words.map((e) => e.entry).toList());
  }
}
