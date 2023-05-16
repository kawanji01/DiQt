// 非同期でMy辞書一覧を取得する
import 'package:booqs_mobile/components/dictionary_map/floating_action_button.dart';
import 'package:booqs_mobile/data/remote/dictionary_maps.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// My辞書一覧
final asyncMyDictionariesProvider =
    FutureProvider<List<Dictionary>?>((ref) async {
  final Map? resMap = await RemoteDictionaryMaps.myDictionaries();
  if (resMap == null) return null;
  List<Dictionary> dictionaries = [];
  resMap['dictionaries']
      .forEach((e) => dictionaries.add(Dictionary.fromJson(e)));
  return dictionaries;
});

// 選択中の辞書
final selectedDictionaryProvider = StateProvider<Dictionary?>((ref) => null);
// 最後に選択した辞書
/* final lastSelectedDictionary = FutureProvider<Dictionary?>((ref) async {
  final String? lastSelectedDictionaryIdStr =
      await LocalUserInfo.getSelectedDictionaryId();
  if (lastSelectedDictionaryIdStr == null) return null;
  final int dictionaryId = int.parse(lastSelectedDictionaryIdStr);
  final Map? resMap = await RemoteDictionaries.show(dictionaryId);
  if (resMap == null) return null;
  final Dictionary dictionary = Dictionary.fromJson(resMap['dictionary']);
  return dictionary;
}); */

// My辞書設定のためのfloatingActionButton
final dictionaryMapFloatingActionButtonProvider =
    StateProvider<Widget?>((ref) => const DictionaryMapFloatingActionButton());

// 追加する辞書のIDのリスト
final additionDictionaryIdsProvider = StateProvider<List<int>>((ref) => []);
// 削除する辞書のIDのリスト
final removalDictionaryIdsProvider = StateProvider<List<int>>((ref) => []);
