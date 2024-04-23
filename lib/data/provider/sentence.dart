import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
