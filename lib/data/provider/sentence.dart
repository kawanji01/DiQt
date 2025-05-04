import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:booqs_mobile/models/dictionary.dart';

// ref: https://riverpod.dev/ja/docs/concepts/modifiers/family
// 【重要】 オブジェクトが一定ではない場合は autoDispose 修飾子との併用が望ましい
// family を使って検索フィールドの入力値をプロバイダに渡す場合、その入力値は頻繁に変わる上に同じ値が再利用されることはありません。
// おまけにプロバイダは参照されなくなっても破棄されないのがデフォルトの動作であるため、この場合はメモリリークにつながります。
final asyncSentenceFamily =
    FutureProvider.autoDispose.family<Sentence?, int>((ref, sentenceId) async {
  final Map resMap = await RemoteSentences.show(sentenceId);
  if (ErrorHandler.isErrorMap(resMap)) return null;
  final Sentence sentence = Sentence.fromJson(resMap['sentence']);
  return sentence;
});

class SentenceControllerMapState
    extends StateNotifier<Map<String, TextEditingController>> {
  SentenceControllerMapState() : super({});

  void initialize(
      {Sentence? sentence, Dictionary? dictionary, String? keyword = ''}) {
    disposeAllItems();
    if (sentence == null) {
      state = {
        'id': TextEditingController(),
        'original': TextEditingController(text: keyword ?? ''),
        'original_ssml': TextEditingController(),
        'translation': TextEditingController(),
        'ja_translation': TextEditingController(),
        'explanation': TextEditingController(),
        'comment': TextEditingController(),
        'dictionary_id':
            TextEditingController(text: dictionary?.id.toString() ?? ''),
      };
    } else {
      state = {
        'id': TextEditingController(text: '${sentence.id}'),
        'original': TextEditingController(text: sentence.original),
        'original_ssml':
            TextEditingController(text: sentence.originalSsml ?? ''),
        'translation': TextEditingController(text: sentence.translation),
        'ja_translation':
            TextEditingController(text: sentence.jaTranslation ?? ''),
        'explanation': TextEditingController(text: sentence.explanation ?? ''),
        'comment': TextEditingController(),
        'dictionary_id':
            TextEditingController(text: dictionary?.id.toString() ?? ''),
      };
    }
  }

  Map<String, dynamic> requestParams() {
    final Map<String, dynamic> params = {};
    if (state.isNotEmpty) {
      for (String key in state.keys) {
        params[key] = state[key]!.text;
      }
    }
    return params;
  }

  void disposeAllItems() {
    if (state.isNotEmpty) {
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

final sentenceControllerMapProvider = StateNotifierProvider<
    SentenceControllerMapState,
    Map<String, TextEditingController>>((ref) => SentenceControllerMapState());
