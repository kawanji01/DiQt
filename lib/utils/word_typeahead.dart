import 'dart:async';
import 'package:booqs_mobile/consts/validation.dart';
import 'package:booqs_mobile/data/remote/words.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/foundation.dart';

// 参考： https://ichi.pro/flutter-de-o-tokonpuri-to-kino-o-jissosuru-hoho-209603487537223
class WordTypeahead {
  // ユーザーが検索フォームに入力したキーワードから、辞書の項目をサジェストする
  static Future<List<Word>> getSuggestions(
      String query, int dictionaryId) async {
    List<Word> words = [];

    if (query.isEmpty && query.length < 3) {
      if (kDebugMode) {
        print('Query needs to be at least 3 chars');
      }
      return [];
    }
    // 辞書に登録できる文字数を超えた場合
    if (query.length > entryLengthLimitation) {
      if (kDebugMode) {
        print('Query needs to be less than $entryLengthLimitation chars');
      }
      return [];
    }

    final Map resMap = await RemoteWords.autocomplete(dictionaryId, query);
    if (ErrorHandler.isErrorMap(resMap)) {
      if (kDebugMode) {
        print('Error');
      }
      return [];
    }

    resMap['words'].forEach((e) => words.add(Word.fromJson(e)));
    return words;
  }
}
