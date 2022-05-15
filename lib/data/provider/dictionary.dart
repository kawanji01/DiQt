import 'package:booqs_mobile/data/remote/dictionaries.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dictionaryProvider = StateProvider<Dictionary?>((ref) => null);
final asyncDictionaryProvider = FutureProvider<Dictionary?>((ref) async {
  final String? publicUid = ref
      .watch(dictionaryProvider.select((dictionary) => dictionary?.publicUid));
  if (publicUid == null) return null;
  final Map? resMap = await RemoteDictionaries.show(publicUid);
  if (resMap == null) return null;
  final Dictionary dictionary = Dictionary.fromJson(resMap['dictionary']);
  ref.read(dictionaryProvider.notifier).state = dictionary;
  return dictionary;
});

// 非同期で辞書一覧を取得する
final asyncDictionariesProvider =
    FutureProvider<List<Dictionary>?>((ref) async {
  final Map? resMap = await RemoteDictionaries.index();
  if (resMap == null) return null;
  List<Dictionary> dictionaries = [];
  resMap['dictionaries']
      .forEach((e) => dictionaries.add(Dictionary.fromJson(e)));

  return dictionaries;
});
