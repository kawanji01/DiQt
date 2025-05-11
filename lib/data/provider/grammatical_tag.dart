import 'package:booqs_mobile/data/remote/dictionaries.dart';
import 'package:booqs_mobile/models/grammatical_tag.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 非同期で引数の辞書の文法タグを取得する
// ref: https://riverpod.dev/ja/docs/concepts/modifiers/family
// 【重要】 オブジェクトが一定ではない場合は autoDispose 修飾子との併用が望ましい
// family を使って検索フィールドの入力値をプロバイダに渡す場合、その入力値は頻繁に変わる上に同じ値が再利用されることはありません。
// おまけにプロバイダは参照されなくなっても破棄されないのがデフォルトの動作であるため、この場合はメモリリークにつながります。
final asyncGrammaticalTagsFamily = FutureProvider.autoDispose
    .family<List<GrammaticalTag>?, int>((ref, dictionaryId) async {
  final Map? resMap = await RemoteDictionaries.grammaticalTags(dictionaryId);
  if (resMap == null) {
    return null;
  }
  final List<GrammaticalTag> grammaticalTags =
      (resMap['grammatical_tags'] as List)
          .map((e) => GrammaticalTag.fromJson(e))
          .toList();
  return grammaticalTags;
});

// GrammaticalTagの選択状態を管理するStateProvider
final grammaticalTagIdsProvider = StateProvider<List<int>>((ref) => []);
