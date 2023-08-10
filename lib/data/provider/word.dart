import 'package:booqs_mobile/data/remote/words.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ref: https://riverpod.dev/ja/docs/concepts/modifiers/family
// 【重要】 オブジェクトが一定ではない場合は autoDispose 修飾子との併用が望ましい
// family を使って検索フィールドの入力値をプロバイダに渡す場合、その入力値は頻繁に変わる上に同じ値が再利用されることはありません。
// おまけにプロバイダは参照されなくなっても破棄されないのがデフォルトの動作であるため、この場合はメモリリークにつながります。
final asyncWordFamily =
    FutureProvider.autoDispose.family<Word?, int>((ref, wordId) async {
  final Map? resMap = await RemoteWords.show(wordId);
  if (resMap == null) return null;
  final Word word = Word.fromJson(resMap['word']);
  ref.read(wordProvider.notifier).state = word;
  return word;
});

final wordProvider = StateProvider<Word?>((ref) => null);

final wordEditDictionaryProvider = StateProvider<Dictionary?>((ref) => null);

//
class WordControllerMapState
    extends StateNotifier<Map<String, TextEditingController>> {
  WordControllerMapState() : super({});

  void initialize(
      {required int dictionaryId,
      Word? word,
      String keyword = '',
      String translation = ''}) {
    disposeAllItems();
    if (word == null) {
      state = {
        'id': TextEditingController(),
        'entry': TextEditingController(text: keyword),
        'reading': TextEditingController(),
        'meaning': TextEditingController(text: translation),
        'pos_tag_id': TextEditingController(),
        'ipa': TextEditingController(),
        'sentence_id': TextEditingController(),
        'dictionary_id': TextEditingController(text: dictionaryId.toString()),
      };
    } else {
      state = {
        'id': TextEditingController(text: '${word.id}'),
        'entry': TextEditingController(text: word.entry),
        'reading': TextEditingController(text: word.reading),
        'meaning': TextEditingController(text: word.meaning),
        'pos_tag_id': TextEditingController(
            text: word.posTagId == null ? '' : word.posTagId.toString()),
        'ipa': TextEditingController(text: word.ipa),
        'sentence_id': TextEditingController(text: word.sentenceId.toString()),
        'dictionary_id': TextEditingController(text: dictionaryId.toString()),
      };
    }
  }

  // create, updateに必要なパラメータを返す
  Map<String, dynamic> requestParams() {
    final Map<String, dynamic> params = {};
    if (state.isEmpty == false) {
      for (String key in state.keys) {
        params[key] = state[key]!.text;
      }
    }
    return params;
  }

  // 全てのcontrollerをdisposeする
  void disposeAllItems() {
    if (state.isEmpty == false) {
      for (TextEditingController controller in state.values) {
        controller.dispose();
      }
      state = {};
    }
  }

  @override
  void dispose() {
    disposeAllItems();
    super.dispose();
  }
}

final wordControllerMapProvider = StateNotifierProvider<WordControllerMapState,
    Map<String, TextEditingController>>((ref) => WordControllerMapState());
