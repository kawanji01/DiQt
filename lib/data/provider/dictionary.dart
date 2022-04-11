import 'package:booqs_mobile/data/remote/dictionaries.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final dictionaryProvider = StateProvider<Quiz?>((ref) => null);

// 非同期で辞書一覧を取得する
final asyncDictionariesProvider =
    FutureProvider<List<Dictionary>?>((ref) async {
  final Map? resMap = await RemoteDictionaries.index();
  if (resMap == null) return null;
  List<Dictionary> dictionaries = [];
  resMap['data'].forEach((e) => dictionaries.add(Dictionary.fromJson(e)));

  return dictionaries;
});
