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

// 非同期で引数の辞書を取得する
// ref: https://riverpod.dev/ja/docs/concepts/modifiers/family
// 【重要】 オブジェクトが一定ではない場合は autoDispose 修飾子との併用が望ましい
// family を使って検索フィールドの入力値をプロバイダに渡す場合、その入力値は頻繁に変わる上に同じ値が再利用されることはありません。
// おまけにプロバイダは参照されなくなっても破棄されないのがデフォルトの動作であるため、この場合はメモリリークにつながります。
final asyncDictionaryFamily = FutureProvider.autoDispose
    .family<Dictionary?, int>((ref, dictionaryId) async {
  final Map? resMap = await RemoteDictionaries.show2(dictionaryId);
  if (resMap == null) return null;
  final Dictionary dictionary = Dictionary.fromJson(resMap['dictionary']);
  return dictionary;
});
